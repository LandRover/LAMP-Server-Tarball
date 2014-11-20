#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="7.39.0";
APP_NAME="curl";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

export CPPFLAGS='-I${BIN_DIR}/openssl/include';
export LDFLAGS='-L${BIN_DIR}/openssl/lib';

./configure \
--prefix=${DESTINATION};

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};