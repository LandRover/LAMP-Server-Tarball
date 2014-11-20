#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_NAME="php-fpm";
ETC_DIR="/opt/local/etc";

../helpers/post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}";

## system stop/start on boot
update-rc.d ${APP_NAME} defaults