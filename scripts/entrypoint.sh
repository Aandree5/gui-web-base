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

# Target PUID and PGID
PUID=${PUID:-${GWB_UID:-1000}}
PGID=${PGID:-${GWB_GID:-1000}}

# Current gwb UID and GID
CURRENT_UID=$(id -u gwb || echo -1)
CURRENT_GID=$(id -g gwb || echo -1)

# Directories to fix permissions for downstream image
export APP_DIRS=""
# All directories to fix permissions
PERMISSIONS_DIRS="/home/gwb ${XDG_RUNTIME_DIR} ${APP_DIRS}"

echo "Current UID:GID = ${CURRENT_UID:-<missing>}:${CURRENT_GID:-<missing>}"
echo "Target UID:GID = ${PUID}:${PGID}"

TARGET_USER="gwb"
TARGET_GROUP="gwb"

# Update permissions only if current UID or GID differ from target
if [ "${CURRENT_UID}" != "${PUID}" ] || [ "${CURRENT_GID}" != "${PGID}" ]; then
    # Ensure group exists for PGID (create if missing)
    if getent group "${PGID}" >/dev/null 2>&1; then
        TARGET_GROUP=$(getent group "${PGID}" | cut -d: -f1)
        echo "Using existing group ${TARGET_GROUP} (GID ${PGID})"
    else
        # If gwb exists, modify it, otherwise create new user
        if [ "${CURRENT_GID}" -ge 0 ]; then
            echo "Modifying existing group gwb to GID:${PGID}"
            groupmod -g "${PGID}" "gwb"
        else
            echo "Creating group ${TARGET_GROUP} with GID ${PGID}"
            groupadd -g "${PGID}" "${TARGET_GROUP}"
        fi
    fi
    
    # Ensure a user exists with the target PUID
    if getent passwd "${PUID}" >/dev/null 2>&1; then
        TARGET_USER=$(getent passwd "${PUID}" | cut -d: -f1)
        echo "Found existing user ${TARGET_USER} with UID ${PUID}"
    else
        # If gwb exists, modify it, otherwise create new user
        if [ "${CURRENT_UID}" -ge 0 ]; then
            echo "Modifying existing user gwb to UID:${PUID} GID:${PGID}"
            usermod -u "${PUID}" -g "${PGID}" "gwb"
        else
            echo "Creating user gwb with UID:${PUID} GID:${PGID}"
            useradd -m -u "${PUID}" -g "${PGID}" -d "/home/gwb" -s /bin/sh gwb
        fi
    fi
    
    # Fix ownership of directories
    for d in ${PERMISSIONS_DIRS}; do
        if [ -e "${d}" ]; then
            echo "Fixing ownership for ${d} -> ${PUID}:${PGID}"
            
            if ! chown -R "${PUID}:${PGID}" "${d}"; then
                echo "ERROR: failed to set ownership on ${d} to ${PUID}:${PGID}" >&2
                exit 1
            fi
        else
            echo "Creating ${d} owned by ${PUID}:${PGID}"
            mkdir -p "${d}"
            chown "${PUID}:${PGID}" "${d}"
            chmod 700 "${d}"
        fi
    done
else
    TARGET_USER=$(getent passwd "${PUID}" | cut -d: -f1)
fi

echo "Executing as ${TARGET_USER}"
exec dumb-init -- gosu "${TARGET_USER}" "$@"
