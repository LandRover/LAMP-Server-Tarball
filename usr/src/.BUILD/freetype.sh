#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="2.7.1";
DIST_URL="http://download.savannah.gnu.org/releases/freetype/freetype-${VERSION}.tar.gz";
APP_NAME="freetype";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

export LIBPNG_LIBS="-L${BIN_DIR}/libpng/lib";
export LIBPNG_CFLAGS="-I${BIN_DIR}/libpng/include";

./configure \
--prefix=${DESTINATION} \
--with-png=yes;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};