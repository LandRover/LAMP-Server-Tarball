#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl libidn2 nghttp2 zlib);

# build data
VERSION="7.69.1";
DIST_URL="https://curl.haxx.se/download/curl-${VERSION}.tar.gz";
APP_NAME="curl";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--disable-shared \
--enable-shared=no \
--enable-ipv6 \
--enable-cookies \
--with-random=/dev/urandom \
--with-ssl=${BIN_DIR}/openssl \
--with-zlib=${BIN_DIR}/zlib \
--with-libidn2=${BIN_DIR}/libidn2 \
--with-nghttp2=${BIN_DIR}/nghttp2;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
