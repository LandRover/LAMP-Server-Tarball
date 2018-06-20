#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib);

# build data
BUILD="../${PWD##*/}";
VERSION="1.6.34";
DIST_URL="https://netix.dl.sourceforge.net/project/libpng/libpng16/${VERSION}/libpng-${VERSION}.tar.gz";
APP_NAME="libpng";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

export CPPFLAGS="-I${BIN_DIR}/zlib/include";
export LDFLAGS="-L${BIN_DIR}/zlib/lib";

./configure \
--prefix=${DESTINATION} \
--with-zlib-prefix=${BIN_DIR}/zlib \
--disable-static;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};