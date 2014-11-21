#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# Unpacks source packages at /usr/src
# file is loaded via SOURCE and must NOT BE executed directly.

OVERWRITE="$1"; ## first arg, 1 is overwrite on.
PACKAGE="../${APP_NAME}-${VERSION}.tgz";

function error {
    echo $1;
    echo "";

    exit 0;
}

[[ ! -e "${PACKAGE}" ]] && error "PACKAGE ${PACKAGE} not found";

## on overwrite option on, deletes the old build first.
[[ "1" = OVERWRITE &&  -d "../${APP_NAME}" ]] && rm -rf "../${APP_NAME}";
[[ "1" = OVERWRITE &&  -d "../${APP_NAME}-${VERSION}" ]] && rm -rf "../${APP_NAME}-${VERSION}";

tar -zxvf "${PACKAGE}" -C ../; # unpack it
cd ..; # get one folder above to /usr/src, if not, link will be damaged.
./.BUILD/helpers/bin/ln.sh "${APP_NAME}-${VERSION}" "${APP_NAME}"; ## create link

## enter src app dir
cd "${APP_NAME}";

## removes old configure etc..
make clean;
