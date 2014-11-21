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

## system stop/start on boot
update-rc.d ${APP_NAME} defaults

## create logs dir
mkdir /var/log/${APP_NAME};
chown ${USER}:${USER} /var/log/${APP_NAME};