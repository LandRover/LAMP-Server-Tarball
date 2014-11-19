#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

/sbin/ldconfig -v ${BIN_DIR}/${APP_NAME}/lib;