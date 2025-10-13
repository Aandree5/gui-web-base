#!/bin/sh

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
    --session-name=picard-session \
    --start="$APP_CMD" & XPRA_PID=$!

sleep 5

while kill -0 "$XPRA_PID" 2>/dev/null; do
    # Check if app is running inside Xpra
    if ! xpra control :100 list-windows | grep -q "$APP_NAME"; then
        echo "[WARN] $APP_NAME not found in Xpra session. Restarting..."
        xpra control :100 start "$APP_CMD"
    fi
    sleep 2
done

echo "[ERROR] Xpra process $XPRA_PID has exited. Monitor shutting down."