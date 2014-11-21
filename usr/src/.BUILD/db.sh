#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="6.1.19";
APP_NAME="db";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./dist/configure \
--prefix=${DESTINATION} \
--enable-compat185 \
--enable-dbm \
--disable-static \
--enable-cxx;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};