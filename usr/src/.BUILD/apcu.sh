#!/bin/bash

apt-get -y install libpcre3-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(php);

# build data
BUILD="../${PWD##*/}";
VERSION="4.0.7";
APP_NAME="apcu";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

${BIN_DIR}/php/bin/phpize;

./configure \
--with-php-config=${BIN_DIR}/php/bin/php-config;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};