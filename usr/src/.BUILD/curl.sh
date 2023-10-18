#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl libidn2 nghttp2 zlib);

# build data
VERSION="8.4.0";
DIST_URL="https://curl.haxx.se/download/curl-${VERSION}.tar.gz";
APP_NAME="curl";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--disable-static \
--enable-threaded-resolver \
--enable-ipv6 \
--enable-cookies \
--with-random=/dev/urandom \
--with-ssl=${BIN_DIR}/openssl \
--with-ca-path=/etc/ssl/certs \
--with-zlib=${BIN_DIR}/zlib \
--with-libidn2=${BIN_DIR}/libidn2 \
--with-nghttp2=${BIN_DIR}/nghttp2 \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
