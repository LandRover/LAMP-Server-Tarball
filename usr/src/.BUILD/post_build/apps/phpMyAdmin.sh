#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

ETC_DIR="/opt/local/etc";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME} /var/www/${APP_NAME};
../helpers/bin/ln.sh ${ETC_DIR}/${APP_NAME}/config.inc.php /var/www/${APP_NAME}/config.inc.php;

chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME}-${VERSION} ${BIN_DIR}/${APP_NAME} /var/www/${APP_NAME} ${ETC_DIR}/${APP_NAME};