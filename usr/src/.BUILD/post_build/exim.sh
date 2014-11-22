#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

ETC_DIR="/opt/local/etc";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

## init.d
../helpers/post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}";

## logrotate.d
../helpers/post_etc_ln.sh "${ETC_DIR}" "logrotate.d" "${APP_NAME}";

## profile.d
../helpers/post_etc_ln.sh "${ETC_DIR}" "profile.d" "${APP_NAME}.sh";

## system stop/start on boot
update-rc.d ${APP_NAME} defaults

## create logs dir
[ ! -d "/var/log/${APP_NAME}" ] && mkdir "/var/log/${APP_NAME}" && chown -R ${USER}:${USER} /var/log/${APP_NAME};

## restart service
/etc/init.d/${APP_NAME} restart