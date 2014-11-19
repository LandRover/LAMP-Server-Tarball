#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME}
#scripts/mysql_install_db --user=${APP_NAME}