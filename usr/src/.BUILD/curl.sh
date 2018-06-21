#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
BUILD="../${PWD##*/}";
VERSION="7.55.0";
DIST_URL="https://curl.haxx.se/download/curl-${VERSION}.tar.gz";
APP_NAME="curl";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

export CPPFLAGS="-I${BIN_DIR}/openssl/include";
export LDFLAGS="-L${BIN_DIR}/openssl/lib";
export PKG_CONFIG_PATH="${BIN_DIR}/openssl/lib/pkgconfig";

./configure \
--prefix=${DESTINATION} \
--disable-shared \
--with-ssl \
--enable-cookies;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};
