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

# Target PUID and PGID
PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Current gwb UID and GID
CURRENT_UID=$(id -u gwb || echo -1)
CURRENT_GID=$(id -g gwb || echo -1)

# $APP_DIRS - Directories to fix permissions for downstream image
# All directories to fix permissions
PERMISSIONS_DIRS="$GWB_HOME $XDG_RUNTIME_DIR /var/lib/nginx /gwb /run/dbus ${APP_DIRS:-}"

echo "Current UID:GID = ${CURRENT_UID:-<missing>}:${CURRENT_GID:-<missing>}"
echo "Target UID:GID = $PUID:$PGID"

TARGET_USER="gwb"
TARGET_GROUP="gwb"

fix_dirs_permissions() {
    for d in $PERMISSIONS_DIRS; do
        if [ -e "$d" ]; then
            dir_uid=$(stat -c '%u' "$d")
            dir_gid=$(stat -c '%g' "$d")
            
            if [ "$dir_uid" != "$PUID" ] || [ "$dir_gid" != "$PGID" ]; then
                echo "Fixing ownership for $d (was $dir_uid:$dir_gid, needs $PUID:$PGID)"
                if ! chown -R "$PUID:$PGID" "$d"; then
                    echo "ERROR: failed to set ownership on $d to $PUID:$PGID" >&2
                    exit 1
                fi
            fi
        else
            echo "Creating $d owned by $PUID:$PGID"
            mkdir -p "$d"
            chown "$PUID:$PGID" "$d"
            chmod 700 "$d"
        fi
    done
}

# Update permissions only if current UID or GID differ from target
if [ "$CURRENT_UID" != "$PUID" ] || [ "$CURRENT_GID" != "$PGID" ]; then
    # Ensure group exists for PGID (create if missing)
    if getent group "$PGID" >/dev/null 2>&1; then
        TARGET_GROUP=$(getent group "$PGID" | cut -d: -f1)
        echo "Using existing group $TARGET_GROUP (GID $PGID)"
    else
        # If gwb exists, modify it, otherwise create new user
        if [ "$CURRENT_GID" -ge 0 ]; then
            echo "Modifying existing group gwb to GID:$PGID"
            groupmod -g "$PGID" "gwb"
        else
            echo "Creating group $TARGET_GROUP with GID $PGID"
            groupadd -g "$PGID" "$TARGET_GROUP"
        fi
    fi
    
    # Ensure a user exists with the target PUID
    if getent passwd "$PUID" >/dev/null 2>&1; then
        TARGET_USER=$(getent passwd "$PUID" | cut -d: -f1)
        echo "Found existing user $TARGET_USER with UID $PUID"
    else
        # If gwb exists, modify it, otherwise create new user
        if [ "$CURRENT_UID" -ge 0 ]; then
            echo "Modifying existing user gwb to UID:$PUID GID:$PGID"
            usermod -u "$PUID" -g "$PGID" "gwb"
        else
            echo "Creating user gwb with UID:$PUID GID:$PGID"
            useradd -m -u "$PUID" -g "$PGID" -d "$GWB_HOME" -s /bin/sh gwb
        fi
    fi
    
    # Fix ownership of directories
    fix_dirs_permissions
else
    TARGET_USER=$(getent passwd "$PUID" | cut -d: -f1)
    
    # Check PERMISSIONS_DIRS even if UID/GID are unchanged
    # Make sure ownership is correct
    fix_dirs_permissions
fi

# Generate self-signed SSL certificate if not present
SSL_DIR="/gwb/ssl"
SSL_CERT_PATH="$SSL_DIR/ssl-cert.pem"
SSL_CERT_KEY_PATH="$SSL_DIR/key.pem"
SSL_CERT_CRT_PATH="$SSL_DIR/crt.pem"
    
if [ ! -f $SSL_CERT_PATH ]; then
    echo "Generating new self-signed SSL certificate..."

    mkdir -p "$SSL_DIR"
    
    openssl req -new -x509 -days 365 -nodes -out "$SSL_CERT_CRT_PATH" -keyout "$SSL_CERT_KEY_PATH" -sha256  -subj "/CN=localhost" -addext "subjectAltName = DNS:localhost,IP:127.0.0.1"
    cat "$SSL_CERT_KEY_PATH" "$SSL_CERT_CRT_PATH" > "$SSL_CERT_PATH"
    
    chown "$PUID:$PGID" "$SSL_DIR" "$SSL_CERT_PATH" "$SSL_CERT_KEY_PATH" "$SSL_CERT_CRT_PATH"
    chmod 700 "$SSL_DIR" "$SSL_CERT_PATH" "$SSL_CERT_KEY_PATH" "$SSL_CERT_CRT_PATH"
else
    echo "Using existing SSL certificate at $SSL_CERT_PATH"
fi

echo "Executing as $TARGET_USER"
exec dumb-init -- gosu $TARGET_USER "$@"
