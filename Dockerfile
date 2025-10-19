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
LABEL maintainer="André Silva"

ARG UID=1000
ARG GID=1000
ENV UID=$UID
ENV GID=$GID

# Add xpra repository
RUN apt-get update \
    && apt-get install -y \
    wget \
    && apt-get install ca-certificates \
    && wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
    && cd /etc/apt/sources.list.d ; wget "https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra.sources"

RUN apt-get update \
    && apt-get install -y \
    xpra \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r -g ${GID} guiwebuser \
    && useradd -u ${UID} -g ${GID} -m -d /home/guiwebuser -s /bin/bash guiwebuser \
    # No password login
    #&& echo "guiwebuser:${PASSWORD}" | chpasswd && \
    && mkdir -m 755 -p /var/lib/dbus \
    && dbus-uuidgen > /var/lib/dbus/machine-id

#### SETUP USER, DIRECTORIES AND PERMISSIONS ####

# Group socket directory with the correct permissions, owned by guiwebuser.
RUN mkdir -p /run/xpra && chown guiwebuser:guiwebuser /run/xpra && chmod 775 /run/xpra

# Doamin socket directory with the correct permissions, owned by guiwebuser.
RUN mkdir -p /run/user/${UID}/xpra && chown guiwebuser:guiwebuser /run/user/${UID}/xpra && chmod 775 /run/user/${UID}/xpra

COPY scripts/start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

WORKDIR /home/guiwebuser
USER guiwebuser

EXPOSE 5005

# Simple healthcheck to ensure xpra is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --spider --quiet http://localhost:5005/ || exit 1

CMD ["start"]

FROM alpine:3.20 AS alpine-build
LABEL maintainer="André Silva"

ARG UID=1000
ARG GID=1000
ENV UID=$UID
ENV GID=$GID

RUN apk update && \
    apk add --no-cache \
    xpra \
    dbus \
    dbus-x11 \
    pulseaudio \
    pulseaudio-utils \
    xauth

RUN mkdir /usr/share/xpra/www \
    && cd /usr/share/xpra/www \
    && wget https://xpra.org/src/xpra-html5-17.1.tar.xz \
    && tar -Jxf xpra-html5-17.1.tar.xz xpra-html5-17.1/html5 --strip-components=2 \
    && rm -f xpra-html5-17.1.tar.xz

RUN addgroup -g ${GID} -S guiwebuser \
    # No password login (default with -D, no password set)
    && adduser  -u ${UID} -G guiwebuser -h /home/guiwebuser -s /bin/bash -D guiwebuser \
    && mkdir -m 755 -p /var/lib/dbus \
    && dbus-uuidgen > /var/lib/dbus/machine-id

#### SETUP USER, DIRECTORIES AND PERMISSIONS ####

# Group socket directory with the correct permissions, owned by guiwebuser.
RUN mkdir -p /run/xpra && chown guiwebuser:guiwebuser /run/xpra && chmod 775 /run/xpra

COPY scripts/start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

WORKDIR /home/guiwebuser
USER guiwebuser

EXPOSE 5005

# Simple healthcheck to ensure xpra is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --spider --quiet http://localhost:5005/ || exit 1

CMD ["start"]

# ---- Healthcheck test stage for CI checks (adds xclock) ----
# This stage is used in CI to test the healthcheck functionality.
# Will not be present in the final image, so not adding unnecessary packages to the final image.
FROM debian-build AS ci-healthcheck-debian

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends xterm

USER guiwebuser

CMD ["start", "xterm"]

# ---- Healthcheck test stage for CI checks (adds xclock) ----
# This stage is used in CI to test the healthcheck functionality.
# Will not be present in the final image, so not adding unnecessary packages to the final image.
FROM alpine-build AS ci-healthcheck-alpine

USER root

RUN apk update && \
    apk add --no-cache xterm

USER guiwebuser

CMD ["start", "xterm"]

# ---- Final build ----
# This is the stage used for the final image (default).
FROM debian-build AS default-build
