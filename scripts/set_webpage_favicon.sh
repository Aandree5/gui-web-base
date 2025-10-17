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


HTML_FILE="/usr/share/xpra/www/index.html"
FAVICON_FILE="${1}"

if [ ! -f "$HTML_FILE" ]; then
    echo "File not found: $HTML_FILE"
    exit 1
fi

if [ ! -f "$FAVICON_FILE" ]; then
    sed -i '/<!-- FAVICON -->/,/<!-- FAVICON -->/d' $HTML_FILE
    
    echo "Favicon removed in $HTML_FILE"
    exit 0
fi

FAVICON_CONTENT=$(cat "$FAVICON_FILE")

# Determine insertion point: <title> or <head>
# Title should exists at this point, but just in case it doesn't
if grep -q "<title>" "$HTML_FILE"; then
    INSERT_TAG="<title>"
else
    INSERT_TAG="<head>"
fi

sed -i "/$INSERT_TAG/a <!-- FAVICON -->" "$HTML_FILE"

# Reverse the lines and insert each one after <title>
# `tac` prints lines in reverse order
tac "$FAVICON_FILE" | while IFS= read -r line; do
    sed -i "/$INSERT_TAG/a $line" "$HTML_FILE"
done

sed -i "/$INSERT_TAG/a <!-- FAVICON -->" "$HTML_FILE"

echo "Favicon set in $HTML_FILE"
