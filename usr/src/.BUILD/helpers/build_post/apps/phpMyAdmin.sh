#!/bin/bash

USER="${PARAM1}";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

../../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME} /home/apache/public_html/${APP_NAME};
../../helpers/bin/ln.sh ${ETC_DIR}/${APP_NAME}/config.inc.php /home/apache/public_html/${APP_NAME}/config.inc.php;

chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME}-${VERSION} ${BIN_DIR}/${APP_NAME} /home/apache/public_html/${APP_NAME} ${ETC_DIR}/${APP_NAME};