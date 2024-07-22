#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl gmp);

# build data
VERSION="3.10";
DIST_URL="https://ftp.gnu.org/gnu/nettle/nettle-${VERSION}.tar.gz";
APP_NAME="nettle";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
CFLAGS="-m64" \
OPENSSL_LIBFLAGS="${BIN_DIR}/openssl/lib64" \
--with-include-path="${BIN_DIR}/openssl/include:${BIN_DIR}/gmp/include" \
--with-lib-path="${BIN_DIR}/openssl/lib64:${BIN_DIR}/gmp/lib" \
--disable-static \
--enable-shared \
--enable-openssl \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
