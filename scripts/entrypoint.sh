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

set -eu

# Default umask
UMASK=${UMASK:-077}
umask $UMASK
echo "Using umask: $UMASK"

# $APP_DIRS - space-separated list of directories the app needs write access to
for d in ${APP_DIRS:-}; do
    if [ ! -e "$d" ]; then
        mkdir -p "$d" 2>/dev/null || true
    fi
    
    if [ ! -w "$d" ]; then
        echo "ERROR: $d is not writable by uid $(id -u):$(id -g)." >&2
        echo "       Make it writable on the host, or run with --user matching its owner." >&2
        exit 1
    fi
done

# Per-UID tree, created by the running process so it is owned by whatever --user was given
GWB_RUN_DIR="${GWB_RUN_BASE:-/run/gwb}/$(id -u)"
HOME="$GWB_RUN_DIR/home"
XDG_RUNTIME_DIR="$GWB_RUN_DIR/xdg"
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
GWB_SSL_DIR="$GWB_RUN_DIR/ssl"
export GWB_RUN_DIR HOME XDG_RUNTIME_DIR XDG_CONFIG_HOME XDG_CACHE_HOME GWB_SSL_DIR

if ! mkdir -p "$XDG_RUNTIME_DIR" "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$GWB_SSL_DIR" "$GWB_RUN_DIR/nginx/temp"; then
    echo "ERROR: cannot create runtime state under $GWB_RUN_DIR as uid $(id -u):$(id -g)." >&2
    echo "       Mount a writable volume at ${GWB_RUN_BASE:-/run/gwb}, or run without a read-only root filesystem." >&2
    exit 1
fi

# xpra and pulseaudio refuse an XDG_RUNTIME_DIR that is not 0700
if ! chmod 700 "$GWB_RUN_DIR" "$XDG_RUNTIME_DIR"; then
    echo "ERROR: $GWB_RUN_DIR exists but is not owned by uid $(id -u):$(id -g)." >&2
    echo "       Remove it, or run with --user matching its owner." >&2
    exit 1
fi

# dbus and pulseaudio fail outright if the running uid has no passwd entry
if ! getent passwd "$(id -u)" >/dev/null 2>&1; then
    # Copied, not generated, because NSS_WRAPPER_PASSWD replaces the database rather than extending it
    cp /etc/passwd "$GWB_RUN_DIR/passwd"
    cp /etc/group "$GWB_RUN_DIR/group"
    echo "gwb$(id -u):x:$(id -u):$(id -g):gwb:$HOME:/bin/sh" >> "$GWB_RUN_DIR/passwd"
    
    if ! getent group "$(id -g)" >/dev/null 2>&1; then
        echo "gwb$(id -g):x:$(id -g):" >> "$GWB_RUN_DIR/group"
    fi
    
    export NSS_WRAPPER_PASSWD="$GWB_RUN_DIR/passwd"
    export NSS_WRAPPER_GROUP="$GWB_RUN_DIR/group"
    export LD_PRELOAD=/usr/local/lib/libnss_wrapper.so
fi

# Generate self-signed SSL certificate if not present
SSL_CERT_PATH="$GWB_SSL_DIR/ssl-cert.pem"
SSL_CERT_KEY_PATH="$GWB_SSL_DIR/key.pem"

if [ ! -f "$SSL_CERT_PATH" ]; then
    echo "Generating new self-signed SSL certificate..."
    
    SSL_CERT_CRT_PATH="$GWB_SSL_DIR/crt.pem"
    openssl req -new -x509 -days 365 -nodes -out "$SSL_CERT_CRT_PATH" -keyout "$SSL_CERT_KEY_PATH" -sha256  -subj "/CN=localhost" -addext "subjectAltName = DNS:localhost,IP:127.0.0.1"
    cat "$SSL_CERT_KEY_PATH" "$SSL_CERT_CRT_PATH" > "$SSL_CERT_PATH"
    rm -f "$SSL_CERT_CRT_PATH"
    chmod 600 "$SSL_CERT_PATH" "$SSL_CERT_KEY_PATH"
else
    echo "Using existing SSL certificate at $SSL_CERT_PATH"
fi

echo "Executing as uid $(id -u):$(id -g)"
exec dumb-init -- "$@"
