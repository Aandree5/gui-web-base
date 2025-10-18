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


# Require an app command as the first argument
if [ -z "$1" ]; then
    echo "[ERROR] No application command provided."
    echo "Usage: $0 <app_command>"
    exit 1
fi

APP_CMD="$1"
APP_NAME=$(basename "$APP_CMD")

export XDG_RUNTIME_DIR="/home/guiwebuser/.xdg"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

mkdir -p /home/guiwebuser/.xpra
chmod 700 /home/guiwebuser/.xpra

# Start PulseAudio in user mode
pulseaudio --start --exit-idle-time=-1 --log-level=error --disallow-exit

xpra start :100 \
    --bind-tcp=0.0.0.0:5005 \
    --html=on \
    --exit-with-children=no \
    --mdns=no \
    --webcam=no \
    --daemon=no \
    --socket-dir="/home/guiwebuser/.xpra" \
    --session-name="GUI web app" \
    --window-close=ignore \
    --start="$APP_CMD" & XPRA_PID=$!

sleep 5

while kill -0 "$XPRA_PID" 2>/dev/null; do
    if ! pgrep -x "$APP_CMD" >/dev/null; then
        echo "[WARN] $APP_NAME not found in Xpra session. Restarting..."
        xpra control :100 start "$APP_CMD"
    fi
    sleep 2
done

echo "[ERROR] Xpra process $XPRA_PID has exited. Monitor shutting down."
