#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As mysql setup requires a user.";

chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME}
#scripts/mysql_install_db --user=${USER}