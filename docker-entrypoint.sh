#!/bin/bash
set -eo pipefail

LOCATE_MODS_COMMAND="find $MODS_LOC -maxdepth 1 -mindepth 1 -type d"

if [[ $($LOCATE_MODS_COMMAND | wc -l) -ge 1 ]]; then
    mods_arg="-mod=$($LOCATE_MODS_COMMAND -print0 | sed -i 's/\x0/\\;/g' | sed -i 's/\\;$//')"
else
    mods_arg=""
fi

start_cmd="-config=/config/server.cfg $mods_arg $@"
printf "Entrypoint script: passing arguments: $start_cmd\n"
$INSTALL_LOC/arma3server $start_cmd
