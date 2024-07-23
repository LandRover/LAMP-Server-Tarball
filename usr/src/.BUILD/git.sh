#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl zlib curl pcre2 libexpat);

# build data
VERSION="2.45.2";
DIST_URL="https://github.com/git/git/archive/refs/tags/v${VERSION}.tar.gz";
APP_NAME="git";

source ./helpers/build_pre/.pre-start.sh;

export CFLAGS="-I${BIN_DIR}/openssl/include";
export LDFLAGS="-L${BIN_DIR}/openssl/lib64";

make configure;

./configure \
--prefix=${DESTINATION} \
ZLIB_PATH=${BIN_DIR}/zlib \
CURLDIR=${BIN_DIR}/curl \
OPENSSLDIR=${BIN_DIR}/openssl \
LIBPCREDIR=${BIN_DIR}/pcre2 \
--sysconfdir=${ETC_DIR}/${APP_NAME} \
--with-openssl \
--with-libpcre2 \
--with-zlib="${BIN_DIR}/zlib" \
--with-curl \
--with-expat \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
