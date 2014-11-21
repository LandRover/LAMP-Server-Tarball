#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="1.6.14";
APP_NAME="libpng";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

export CPPFLAGS="-I${BIN_DIR}/zlib/include";

./configure \
--prefix=${DESTINATION} \
--disable-static;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};