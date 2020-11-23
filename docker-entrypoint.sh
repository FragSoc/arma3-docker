#!/bin/sh

LOCATE_MODS_COMMAND="find $MODS_LOC -maxdepth 1 -type d -not -wholename $MODS_LOC"

if [[ $($LOCATE_MODS_COMMAND | wc -l) -ge 1 ]]; then
    mods_arg="-mod=$($LOCATE_MODS_COMMAND -print0 | sed -i 's/\x0/\\;/g' | sed -i 's/\\;$//')"
else
    mods_arg=""
fi

$INSTALL_LOC/arma3server -config=/config/server.cfg $mods_arg $@
