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

# Function to write to the correct file
write_mapping() {
    match_type="$1"
    key="${match_type}:$2"
    value="$3"

    case "$match_type" in
        role)           file="10_role.conf" ;;
        title)          file="30_title.conf" ;;
        class-instance) file="50_class.conf" ;;
        commands)       file="70_commands.conf" ;;
        fallback)       file="90_fallback.conf" ;;
        *)
            echo "Unknown match type: $match_type"
            exit 1
            ;;
    esac

    echo "$key=$value" >> "/etc/xpra/content-type/$file"
    echo "Mapped $key to '$value' in $file"
}

for arg in "$@"; do
    case "$arg" in
        --content-type=*)
            entry="${arg#--content-type=}"

            case "$entry" in
                *:*=*) ;;  # valid format
                *)
                    echo "[ERROR] Invalid content-type format: '$entry'" >&2
                    echo "Usage: $0 --content-type=<type>:<key>=<value>" >&2
                    exit 1
                    ;;
            esac

            IFS=':' read -r match_type rest <<< "$entry"
            IFS='=' read -r match_key match_value <<< "$rest"

            write_mapping "$match_type" "$match_key" "$match_value"
            ;;
        *)
            echo "[ERROR] Invalid argument: '$arg'" >&2
            echo "Usage: $0 --content-type=<type>:<key>=<value>" >&2
            exit 1
            ;;
    esac
done
