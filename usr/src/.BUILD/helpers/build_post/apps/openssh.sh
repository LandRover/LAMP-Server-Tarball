#!/bin/bash

#cp -Lf ${ETC_DIR}/init.d/${APP_NAME} /etc/init.d/;
../helpers/post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}"
