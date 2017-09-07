#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib jpeg libpng freetype fontconfig);

# build data
BUILD="../${PWD##*/}";
VERSION="2.2.5";
DIST_URL="https://github.com/libgd/libgd/releases/download/gd-${VERSION}/libgd-${VERSION}.tar.gz";
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
--with-zlib=${BIN_DIR}/zlib \
--with-jpeg=${BIN_DIR}/jpeg \
--with-png=${BIN_DIR}/libpng \
--without-x \
--without-xpm \
--with-freetype=${BIN_DIR}/freetype;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};