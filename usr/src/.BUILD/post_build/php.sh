#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

PHP_FPM="php-fpm";
ETC_DIR="/opt/local/etc";

../helpers/post_etc_ln.sh "${ETC_DIR}" "init.d" "${PHP_FPM}";

## system stop/start on boot
update-rc.d ${PHP_FPM} defaults

## restart service
/etc/init.d/${PHP_FPM} restart