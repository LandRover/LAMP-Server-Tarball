#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="4.0.7";
APP_NAME="apcu";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

make clean;

${BIN_DIR}/php/bin/phpize;

./configure \
--with-php-config=${BIN_DIR}/php/bin/php-config;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};