#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

../helpers/post_etc_ln.sh "${APP_NAME}" "init.d" "${APP_NAME}";