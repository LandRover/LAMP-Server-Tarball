#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

## profile.d
../helpers/post_etc_ln.sh "/opt/local/etc" "profile.d" "${APP_NAME}.sh";
