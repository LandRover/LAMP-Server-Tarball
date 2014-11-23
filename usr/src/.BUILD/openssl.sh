#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="1.0.1j";
APP_NAME="openssl";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./config \
--prefix=${DESTINATION} \
--openssldir=${ETC_DIR}/${APP_NAME} \
zlib-dynamic \
zlib \
enable-tlsext \
shared;

make depend;
make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};