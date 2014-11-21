#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="2.5.3";
APP_NAME="freetype";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

export LIBPNG_CFLAGS="-I${BIN_DIR}/libpng/include";
export LIBPNG_LDFLAGS="-L${BIN_DIR}/libpng/lib";

./configure \
--with-png=yes \
--prefix=${DESTINATION};

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};