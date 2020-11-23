#!/bin/bash
set -eo pipefail

num_mods=$(find $MODS_LOC -maxdepth 1 -mindepth 1 -type d | wc -l)

if [[ $num_mods != 0 ]]; then
    mods_arg="-mod=$(find $MODS_LOC -maxdepth 1 -mindepth 1 -type d -print0 | sed -i 's/\x0/;/g' | sed -i 's/;$//')"
else
    mods_arg=""
fi

start_cmd="-config=/config/server.cfg $mods_arg $@"
printf "Entrypoint script: passing arguments: -config=/config/server.cfg $mods_arg $@\n"
$INSTALL_LOC/arma3server -config=/config/server.cfg "$mods_arg" $@
