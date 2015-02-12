#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib);

# build data
BUILD="../${PWD##*/}";
VERSION="1.6.16";
APP_NAME="libpng";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

export CPPFLAGS="-I${BIN_DIR}/zlib/include";

./configure \
--prefix=${DESTINATION} \
--disable-static;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};