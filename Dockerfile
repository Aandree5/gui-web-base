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

ARG GWB_UID=1000
ARG GWB_GID=1000
ARG GWB_HOME="/home/gwb"
ARG GWB_UMASK=077
ENV GWB_UID=$GWB_UID
ENV GWB_GID=$GWB_GID
ENV GWB_HOME=$GWB_HOME
ENV GWB_UMASK=$GWB_UMASK

EXPOSE 5000
EXPOSE 5443

# Add xpra repository
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
    && cd /etc/apt/sources.list.d ; wget "https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/trixie/xpra.sources"

# xpra packages: https://github.com/Xpra-org/xpra/blob/master/docs/Build/Packaging.md
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    dumb-init \
    gosu \
    xpra \
    xpra-common \
    xpra-server \
    xpra-x11 \
    xpra-codecs \
    xpra-html5 \
    xpra-audio \
    dbus \
    dbus-x11 \
    python3-dbus \
    pulseaudio \
    xauth \
    openssl \
    nginx \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/apt/sources.list.d/xpra.sources \
    && rm -rf /usr/share/keyrings/xpra.asc

RUN groupadd -r -g ${GWB_GID} gwb \
    && useradd -u ${GWB_UID} -g ${GWB_GID} -m -d $GWB_HOME -s /bin/bash gwb

# Socket directory with the correct permissions, owned by gwb.
RUN mkdir -m 755 -p /var/lib/dbus \
    && mkdir -p /gwb/xpra \
    && chown ${GWB_UID}:${GWB_GID} /gwb/xpra \
    && chmod 700 /gwb/xpra \
    && dbus-uuidgen > /var/lib/dbus/machine-id

ENV XDG_RUNTIME_DIR="/gwb/xpra"

# fix: _XSERVTransmkdir: Owner of /tmp/.X11-unix should be set to root
# fix: _XSERVTransmkdir: Mode of /tmp/.X11-unix should be set to 1777
RUN mkdir -p /tmp/.X11-unix \
    && chown -R root:root /tmp/.X11-unix \
    && chmod 1777 /tmp/.X11-unix

# Copy scripts and configuration files
COPY --chown=${GWB_UID}:${GWB_GID} scripts/start-app.sh /usr/local/bin/start-app
RUN chmod +x /usr/local/bin/start-app

COPY --chown=${GWB_UID}:${GWB_GID} scripts/watch-app.sh /usr/local/bin/watch-app
RUN chmod +x /usr/local/bin/watch-app

COPY --chown=${GWB_UID}:${GWB_GID} config/nginx/ /gwb/nginx/

COPY scripts/entrypoint.sh /gwb/entrypoint.sh
RUN chmod +x /gwb/entrypoint.sh

# Container healthcheck
COPY scripts/healthcheck.sh /gwb/healthcheck.sh
RUN chmod +x /gwb/healthcheck.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD /gwb/healthcheck.sh

ENTRYPOINT ["/gwb/entrypoint.sh"]
CMD ["start-app"]

# ---- Healthcheck test stage for CI checks (adds xclock) ----
# This stage is used in CI to test the healthcheck functionality.
FROM debian-build AS ci-healthcheck

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends x11-apps

CMD ["start-app", "xclock"]

# ---- Final stage ----
# This is the stage used for the final image (default).
FROM debian-build
