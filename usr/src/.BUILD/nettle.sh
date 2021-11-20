#!/bin/bash

# build data
VERSION="3.7.3";
DIST_URL="https://ftp.gnu.org/gnu/nettle/nettle-${VERSION}.tar.gz";
APP_NAME="nettle";

source ./helpers/build_pre/.pre-start.sh;

CFLAGS="-m64" ./configure \
--prefix=${DESTINATION} \
--with-include-path="${BIN_DIR}/gmp/include" \
--with-lib-path="${BIN_DIR}/gmp/lib" \
--disable-openssl \
--disable-static \
--enable-shared \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
