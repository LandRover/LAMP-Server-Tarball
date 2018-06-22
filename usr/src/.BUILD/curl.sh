#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
VERSION="7.55.0";
DIST_URL="https://curl.haxx.se/download/curl-${VERSION}.tar.gz";
APP_NAME="curl";

source ./helpers/build_pre/.pre-start.sh;

export CPPFLAGS="-I${BIN_DIR}/openssl/include";
export LDFLAGS="-L${BIN_DIR}/openssl/lib";

./configure \
--prefix=${DESTINATION} \
--disable-shared \
--with-ssl \
--enable-cookies;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};