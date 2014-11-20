#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
ETC_DIR="/opt/local/etc";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

## general init.d settings
../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}/bin/apachectl ${ETC_DIR}/init.d/${APP_NAME};
../helpers/bin/ln.sh ${ETC_DIR}/init.d/${APP_NAME} /etc/init.d/${APP_NAME};

## I like getting there faster..
../helpers/bin/ln.sh ${APP_DIR}/htdocs /var/www;

## profile.d
../helpers/post_etc_ln.sh "${ETC_DIR}" "profile.d" "${APP_NAME}.sh";

## logs
../helpers/bin/ln.sh ${APP_DIR}/logs /var/log/httpd;

## logrorate.d
../helpers/post_etc_ln.sh "${ETC_DIR}" "logrorate.d" "${APP_NAME}";

## security modes and owner changes from root
chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME};
chown -R ${USER}:${USER} ${APP_DIR};
chmod -R go-rwx ${APP_DIR};
chmod -R a-w ${APP_DIR};
chmod o+x ${APP_DIR} ${APP_DIR}/htdocs ${APP_DIR}/cgi-bin;
chmod -R o+r ${APP_DIR}/htdocs;
chmod -R u+w ${APP_DIR}/logs;