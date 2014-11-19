#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="2.6.8";
APP_NAME="mcrypt";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

make clean;

export LD_LIBRARY_PATH=${BIN_DIR}/libmcrypt/lib:${BIN_DIR}/mhash/lib;
export LDFLAGS="-L${BIN_DIR}/mhash/lib/ -I${BIN_DIR}/mhash/include/";
export CFLAGS="-I${BIN_DIR}/mhash/include/";

./configure \
--prefix=${DESTINATION} \
--with-libmcrypt-prefix=${BIN_DIR}/libmcrypt;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};