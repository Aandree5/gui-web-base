# Copyright 2025 André Silva
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Buildkit syntax directive
# syntax=docker/dockerfile:1.4

# ---- Base stage ----
FROM debian:trixie-slim AS debian-build

LABEL org.opencontainers.image.authors="Aandree5" \
    org.opencontainers.image.license="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/Aandree5/gui-web-base" \
    org.opencontainers.image.title="GUI Web Base" \
    org.opencontainers.image.description="Base image for running Linux GUI applications over the web"

ARG UMASK=077
ARG GWB_RUN_BASE="/run/gwb"

ENV UMASK="$UMASK"
ENV GWB_RUN_BASE="$GWB_RUN_BASE"

EXPOSE 5000
EXPOSE 5443

# Add xpra repository
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
    && cd /etc/apt/sources.list.d \
    && wget "https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/trixie/xpra.sources"

# xpra packages: https://github.com/Xpra-org/xpra/blob/master/docs/Build/Packaging.md
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    dumb-init \
    xpra \
    xpra-common \
    xpra-server \
    xpra-x11 \
    xpra-codecs \
    xpra-html5 \
    xpra-audio \
    xpra-audio-server \
    dbus \
    dbus-x11 \
    python3-dbus \
    pulseaudio \
    gstreamer1.0-tools \
    python3-paramiko \
    xauth \
    python3-xdg \
    openssl \
    nginx \
    xfonts-base \
    libnss-wrapper \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/apt/sources.list.d/xpra.sources \
    && rm -rf /usr/share/keyrings/xpra.asc

# Stable path for the entrypoint, the package installs into a multiarch directory.
RUN ln -svf "$(dpkg -L libnss-wrapper | grep -m1 'libnss_wrapper.so$')" /usr/local/lib/libnss_wrapper.so

# Default identity only, any --user works at runtime. Home is created per-UID at startup.
RUN groupadd -r -g 1000 gwb \
    && useradd -M -u 1000 -g 1000 -d "${GWB_RUN_BASE}/1000/home" gwb

# Sticky-writable dirs so any --user can create its own runtime state without root.
RUN mkdir -p "$GWB_RUN_BASE" \
    && chmod 1777 "$GWB_RUN_BASE" \
    && mkdir -m 755 -p /var/lib/dbus \
    && mkdir -p /run/dbus \
    && chmod 1777 /run/dbus \
    && dbus-uuidgen > /var/lib/dbus/machine-id

# XDG menu file
RUN mkdir -p /etc/xdg/menus \
    && cat > /etc/xdg/menus/debian-menu.menu <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN" "https://specifications.freedesktop.org/menu-spec/1.0/menu-1.0.dtd">
<Menu>
  <Name>Applications</Name>
  <Include>
    <Filename>/usr/share/applications</Filename>
    <Filename>/usr/local/share/applications</Filename>
    <Filename>$HOME/.local/share/applications</Filename>
  </Include>
</Menu>
EOF

# fix: _XSERVTransmkdir: Owner of /tmp/.X11-unix should be set to root
# fix: _XSERVTransmkdir: Mode of /tmp/.X11-unix should be set to 1777
RUN mkdir -p /tmp/.X11-unix \
    && chown -R root:root /tmp/.X11-unix \
    && chmod 1777 /tmp/.X11-unix

# Copy scripts and configuration files
COPY config/nginx/ /gwb/nginx/
COPY --chmod=755 scripts/start-app.sh /usr/local/bin/start-app
COPY --chmod=755 scripts/watch-app.sh /usr/local/bin/watch-app
COPY --chmod=755 scripts/configure-xpra.sh /usr/local/bin/configure-xpra
COPY --chmod=755 scripts/entrypoint.sh /gwb/entrypoint.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --spider --no-check-certificate --quiet https://localhost:5443 || exit 1

ENTRYPOINT ["/gwb/entrypoint.sh"]
CMD ["start-app"]

# ---- Healthcheck test stage for CI checks ----
# This stage is used in CI to test the healthcheck functionality.
FROM debian-build AS ci-healthcheck

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xterm

USER gwb
CMD ["start-app", "xterm"]

# ---- Final stage ----
# This is the stage used for the final image (default).
FROM debian-build

# Default identity only; the entrypoint creates all runtime state under the running uid.
USER gwb
