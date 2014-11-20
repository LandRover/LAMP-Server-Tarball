#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

/sbin/ldconfig -v ${BIN_DIR}/${APP_NAME}/lib;

## add ld.so to global
echo "${BIN_DIR}/${APP_NAME}/lib" > "/etc/ld.so.conf.d/${APP_NAME}.conf";