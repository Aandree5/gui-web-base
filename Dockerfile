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

# ---- Base stage ----
FROM debian:bookworm-slim AS base

RUN apt-get update \
    && apt-get install -y \
    xpra \
    python3-dbus \
    dbus-x11 \
    pulseaudio \
    pulseaudio-utils \
    python3-pyqt5 \
    python3-pyinotify \
    python3-xdg \
    xauth \
    ffmpeg \
    wget \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#### CONFIGURATION FILES ####

# xorg configuration
COPY config/xorg.conf /etc/X11/xorg.conf.d/00_gui-web-base.conf

#### SETUP USER, DIRECTORIES AND PERMISSIONS ####

# Create a non-root user to run xpra
RUN adduser guiwebuser --disabled-password

# Create the /tmp/.X11-unix directory with the correct permissions. Must be owned by root, as required by X11.
RUN mkdir -p /tmp/.X11-unix && chown root:root /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

# Create the XDG_RUNTIME_DIR directory with the correct permissions, owned by guiwebuser.
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
FROM base AS ci-healthcheck

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends x11-apps

USER guiwebuser

CMD ["start", "xclock"]

# ---- Final runtime image ----
# This is the stage used for the final image.
# Any images inheriting from this image will not have the CI healthcheck test.
FROM base AS runtime
