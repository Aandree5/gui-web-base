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

write_mapping() {
    match_type="$1"
    key="${match_type}:$2"
    value="$3"
    
    case "$match_type" in
        role)           filename="10_role.conf" ;;
        title)          filename="30_title.conf" ;;
        class-instance) filename="50_class.conf" ;;
        commands)       filename="70_commands.conf" ;;
        fallback)       filename="90_fallback.conf" ;;
        *)
            echo "Unknown match type: $match_type"
            exit 1
        ;;
    esac
    
    comment="# GUI Web Base mappings"
    config_path="/etc/xpra/content-type/$filename"
    mapping="$key=$value"
    
    if ! grep -Fxq "$comment" "$config_path"; then
        printf "\n%s\n" "$comment" >> "$config_path"
    fi
    
    sed -i "/^$comment$/a $mapping" "$config_path"
    echo "Mapped $key to '$value' in $filename"
}

while [ $# -gt 0 ]; do
    case "$1" in
        --content-type)
            shift
            if [ -z "$1" ]; then
                echo "[ERROR] --content-type requires a value."
                echo "Usage: $0 --content-type <type>:<key>=<value>" >&2
                exit 1
            fi
            entry="$1"
            shift
            
            case "$entry" in
                *:*=*) ;;  # valid format
                *)
                    echo "[ERROR] Invalid content-type format: '$entry'" >&2
                    echo "Usage: $0 --content-type <type>:<key>=<value>" >&2
                    exit 1
                ;;
            esac
            
            match_type=${entry%%:*}
            rest=${entry#*:}
            key=${rest%%=*}
            value=${rest#*=}
            
            write_mapping "$match_type" "$key" "$value"
        ;;
        -*)
            echo "Unknown option: $1" >&2
            exit 2
        ;;
        *)
            echo "[ERROR] Invalid argument: '$1'" >&2
            echo "sUsage: $0 --content-type <type>:<key>=<value>" >&2
            exit 1
        ;;
    esac
done
