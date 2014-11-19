#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}/bin/apachectl /opt/local/etc/init.d/${APP_NAME};
../helpers/bin/ln.sh /opt/local/etc/init.d/${APP_NAME} /etc/init.d/${APP_NAME};
../helpers/bin/ln.sh ${APP_DIR}/htdocs /var/www;

chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME};
chown -R ${USER}:${USER} ${APP_DIR};
chmod -R go-rwx ${APP_DIR};
chmod -R a-w ${APP_DIR};
chmod o+x ${APP_DIR} ${APP_DIR}/htdocs ${APP_DIR}/cgi-bin;
chmod -R o+r ${APP_DIR}/htdocs;
chmod -R u+w ${APP_DIR}/logs;