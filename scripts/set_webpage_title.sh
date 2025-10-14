#!/bin/sh
WEBPAGE_TITLE="${1:-GUI web app}"
sed -i "s|<title>.*</title>|<title>${WEBPAGE_TITLE}</title>|" /usr/share/xpra/www/index.html
