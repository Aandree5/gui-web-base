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
FROM debian:bookworm-slim AS debian-build

LABEL org.opencontainers.image.authors="Aandree5" \
      org.opencontainers.image.license="Apache-2.0" \
      org.opencontainers.image.url="https://github.com/Aandree5/gui-web-base" \
      org.opencontainers.image.title="GUI web base" \
      org.opencontainers.image.description="Base image for running Linux GUI applications over the web"

ARG UID=1000
ARG GID=1000
ENV UID=$UID
ENV GID=$GID

# Add xpra repository
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
    && cd /etc/apt/sources.list.d ; wget "https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra.sources"

# xpra packages: https://github.com/Xpra-org/xpra/blob/master/docs/Build/Packaging.md
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    xpra \
    xpra-common \
    xpra-server \
    xpra-x11 \
    xpra-codecs \
    xpra-html5 \
    xpra-audio \
    dbus \
    dbus-x11 \
    pulseaudio \
    xauth \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r -g ${GID} guiwebuser \
    && useradd -u ${UID} -g ${GID} -m -d /home/guiwebuser -s /bin/bash guiwebuser \
    && mkdir -m 755 -p /var/lib/dbus 

# Socket directory with the correct permissions, owned by guiwebuser.
RUN mkdir -p /run/user/${UID}/xpra \
    && chown guiwebuser:guiwebuser /run/user/${UID}/xpra \
    && chmod 700 /run/user/${UID}/xpra \
    && dbus-uuidgen > /var/lib/dbus/machine-id

COPY scripts/start-app.sh /usr/local/bin/start-app
RUN chmod +x /usr/local/bin/start-app

COPY scripts/watch-app.sh /usr/local/bin/watch-app
RUN chmod +x /usr/local/bin/watch-app

WORKDIR /home/guiwebuser
USER guiwebuser

EXPOSE 5005

# Simple healthcheck to ensure xpra is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --spider --quiet http://localhost:5005/ || exit 1

CMD ["start-app"]

# ---- Healthcheck test stage for CI checks (adds xclock) ----
# This stage is used in CI to test the healthcheck functionality.
FROM debian-build AS ci-healthcheck

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends x11-apps

USER guiwebuser

CMD ["start-app", "xclock"]


# ---- Final stage ----
# This is the stage used for the final image (default).
FROM debian-build
