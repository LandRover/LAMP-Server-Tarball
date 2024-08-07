#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(libpng jpeg);

# build data
VERSION="1.4.0";
DIST_URL="https://github.com/webmproject/libwebp/archive/refs/tags/v${VERSION}.tar.gz";
APP_NAME="libwebp";

source ./helpers/build_pre/.pre-start.sh;

./autogen.sh;

./configure \
--prefix=${DESTINATION} \
--enable-libwebpmux \
--enable-libwebpdemux \
--enable-libwebpdecoder \
--enable-libwebpextras \
--enable-swap-16bit-csp \
--with-pngincludedir=${BIN_DIR}/libpng/include \
--with-pnglibdir=${BIN_DIR}/libpng/lib \
--with-jpegincludedir=${BIN_DIR}/jpeg/include \
--with-jpeglibdir=${BIN_DIR}/jpeg/lib \
--disable-static \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
