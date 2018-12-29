#!/bin/bash
set -e

pgid=${PGID:-$(id -u root)}
puid=${PUID:-$(id -g root)}

conf=${CONF_FILE:-"/config/youtube-dl-webui.json"}
host=${HOST:-"0.0.0.0"}
port=${PORT:-5000}

if [[ ! -f ${conf} ]]; then
    echo "Copying sample config file..."
    cp /root/youtube-dl-webui.json /config/youtube-dl-webui.json
fi

if [[ "$*" == python*-m*youtube_dl_webui* ]]; then
    exec gosu $puid:$pgid "$@" -c $conf --host $host --port $port
fi

exec "$@"
