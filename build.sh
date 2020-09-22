#!/bin/bash

set -eo pipefail

APPID=233780
INSTALL_LOC=$PWD/build
USER=$1

docker build -f Dockerfile.pre_install -t fragsoc/arma3_pre_install .

steamcmd +login $USER \
    +force_install_dir $INSTALL_LOC
    +app_update $APPID validate \
    +exit

docker build -f Dockerfile.post_install -t fragsoc/arma3 .
