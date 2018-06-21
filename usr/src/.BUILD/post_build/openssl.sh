#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

ln -s ${BIN_DIR}/${APP_NAME}/include /usr/include/${APP_NAME};