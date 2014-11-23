#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(jpeg libpng freetype fontconfig);

# build data
BUILD="../${PWD##*/}";
VERSION="2.1.0";
APP_NAME="libgd";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./configure \
--prefix=${DESTINATION} \
--with-jpeg=${BIN_DIR}/jpeg \
--with-png=${BIN_DIR}/libpng \
--with-freetype=${BIN_DIR}/freetype \
--with-fontconfig=${BIN_DIR}/fontconfig;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};