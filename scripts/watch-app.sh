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

# Simple respawn wrapper: restarts the child unless --no-restart is passed

# Forward SIGTERM/SIGINT to the child so container shutdown works.
trap 'if [ -n "$child" ]; then kill "$child" 2>/dev/null; fi; exit 0' TERM INT

RESTART=1

# parse options: accept --no-restart before the command
while [ $# -gt 0 ]; do
    case "$1" in
        --no-restart)
            RESTART=0
            shift
        ;;
        --)
            shift
            break
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

if [ $# -eq 0 ]; then
    echo "[ERROR] No command specified for watch-app" >&2
    echo "Usage: $0 [--no-restart] <command> [args...]" >&2
    exit 1
fi

while true; do
    echo "[watch-app] starting: $@"
    "$@" &
    child=$!
    wait "$child"
    rc=$?
    echo "[watch-app] process exited with code $rc"
    if [ "$RESTART" != "1" ]; then
        exit $rc
    fi
    sleep 1
done
