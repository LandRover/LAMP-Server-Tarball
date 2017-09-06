#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="1.1.30";
APP_NAME="libxslt";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./configure \
--prefix=${DESTINATION} \
--with-libxml-prefix=${BIN_DIR}/libxml2 \
--with-libxml-libs-prefix=${BIN_DIR}/libxml2/lib \
--with-libxml-include-prefix=${BIN_DIR}/libxml2/include;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};