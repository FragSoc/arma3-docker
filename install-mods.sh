#!/bin/bash
set -eo pipefail

# Necessary variables
# This needs to be the appid of the client, not the server
APP_ID=107410
# Steam creates it's own folder hierarchy when we download workshop items so we need to extract them
TMP_DIR=/tmp
TMP_DIR_FULL="$TMP_DIR/steamapps/workshop/content/$APP_ID/"
# Mods can only be downloaded by someone who owns the game so we need a username to login with
# Note that this means the script must be run interactively
STEAM_USER=$1
# All other args treated as mod IDs
shift 1
MODS_IDS="$@"

# Generate the single command to download all the mods
install_command=""
for mod_id in "${MODS_IDS[@]}"; do
  install_command="$install_command +workshop_download_item $APP_ID $mod_id"
done

# Download the mods with steamcmd
steamcmd +login $STEAM_USER +force_install_dir /tmp $install_command +quit
# Move them out of the temporary folder
find "$TMP_DIR_FULL" -print0 -maxdepth 1 -mindepth 1 -type d | xargs --null -I{} 'mv {} $MODS_LOC/@$(basename {})'
