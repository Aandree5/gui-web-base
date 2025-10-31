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
BROWSER_TITLE="GUI Web App"

# Parse optional flags
while [ "$1" ]; do
    case "$1" in
        --no-restart)
            RESTART_FLAG="--no-restart"
            shift
        ;;
        --title)
            shift
            if [ -z "$1" ]; then
                echo "[ERROR] --title requires a value.">&2
                echo "Usage: $0 [--title <browser_title>] <app_command> [args...]">&2
                exit 1
            fi
            BROWSER_TITLE="$1"
            shift
        ;;
        --min-quality)
            shift
            if [ -z "$1" ]; then
                echo "[ERROR] --min-quality requires a value.">&2
                echo "Usage: $0 [--min-quality <1-100>] <app_command> [args...]">&2
                exit 1
            fi
            MIN_QUALITY="$1"
            shift
        ;;
        --min-speed)
            shift
            if [ -z "$1" ]; then
                echo "[ERROR] --min-speed requires a value.">&2
                echo "Usage: $0 [--min-speed <1-100>] <app_command> [args...]">&2
                exit 1
            fi
            MIN_SPEED="$1"
            shift
        ;;
        --auto-refresh-delay)
            shift
            if [ -z "$1" ]; then
                echo "[ERROR] --auto-refresh-delay requires a value.">&2
                echo "Usage: $0 [--auto-refresh-delay <seconds>] <app_command> [args...]">&2
                exit 1
            fi
            AUTO_REFRESH_DELAY="$1"
            shift
        ;;
        -*)
            echo "Unknown option: $1" >&2
            exit 2
        ;;
        *)
            break
        ;;
    esac
done

# Require an app command as the first argument
if [ -z "$1" ]; then
    echo "[ERROR] No application command provided.">&2
    echo "Usage: $0 [--no-restart] [--title <browser_title>] <app_command> [args...]">&2
    exit 1
fi

APP_CMD="$@"
APP_NAME=$(basename "$APP_CMD")

ALLOW_HTTP=${ALLOW_HTTP:-true}
if [ $ALLOW_HTTP = true ]; then
    echo "[INFO] HTTP connections are allowed."
    NGINX_CONFIG="/gwb/nginx/nginx.noredirect.conf"
else
    echo "[INFO] HTTP connections will be redirected to HTTPS."
    NGINX_CONFIG="/gwb/nginx/nginx.conf"
fi

# Start NGINX
echo "[INFO] Starting NGINX"
nginx -c "$NGINX_CONFIG" -g 'pid /gwb/nginx/nginx.pid;'

echo "[INFO] Starting application: $APP_NAME"
# (opengl=auto) - Disable OpenGL when not supported, like for alpine build for a smaller image (for OpenGL support use debian build)
xpra seamless :100 \
--bind-tcp=127.0.0.1:3000 \
--ssl-cert=/gwb/ssl/ssl-cert.pem \
--html=on \
--exit-with-children=no \
--daemon=no \
--session-name="$BROWSER_TITLE" \
--socket-dirs="$XDG_RUNTIME_DIR" \
--window-close=ignore \
--opengl=auto \
--ssh=no \
--mdns=no \
--pulseaudio=yes \
--clipboard=yes \
--clipboard-direction=both \
--file-transfer=yes \
--webcam=no \
--min-quality=${MIN_QUALITY:-0} \
--min-speed=${MIN_SPEED:-0} \
--auto-refresh-delay=${AUTO_REFRESH_DELAY:-0.25} \
--start="watch-app $RESTART_FLAG -- \"$APP_CMD\""
