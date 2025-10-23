#!/bin/sh
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

RESTART_FLAG=""

if [ "$1" = "--no-restart" ]; then
    RESTART_FLAG="--no-restart"
    shift
fi

# Require an app command as the first argument
if [ -z "$1" ]; then
    echo "[ERROR] No application command provided."
    echo "Usage: $0 [--no-restart] <app_command> [args...]"
    exit 1
fi

APP_CMD="$1"
APP_NAME=$(basename "$APP_CMD")

if [ "$ENABLE_SSL" = "true" ]; then
    SSL_FLAGS="--bind-ssl=0.0.0.0:5005 --ssl-cert=/pw/ssl/ssl-cert.pem"
else
    SSL_FLAGS="--bind-tcp=0.0.0.0:5005"
fi

# (opengl=auto) - Disable OpenGL when not supported, like for alpine build for a smaller image (for OpenGL support use debian build)
xpra seamless :100 \
    $SSL_FLAGS \
    --auth=none \
    --html=on \
    --exit-with-children=no \
    --daemon=no \
    --session-name="GUI web app" \
    --socket-dirs=$XDG_RUNTIME_DIR \
    --window-close=ignore \
    --opengl=auto \
    --start="watch-app $RESTART_FLAG -- $APP_CMD"
