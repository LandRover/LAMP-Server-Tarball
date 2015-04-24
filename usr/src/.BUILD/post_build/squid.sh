#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
ETC_DIR="/opt/local/etc";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As squid setup requires a user.";

## create and own logs
[ ! -d "/var/log/${APP_NAME}" ] && mkdir /var/log/${APP_NAME} && chown ${USER}:${USER} /var/log/${APP_NAME};
