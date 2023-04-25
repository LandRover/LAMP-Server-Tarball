#!/bin/bash

## libs required
apt-get -y install gperf \
uuid-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(freetype libpng libxml2);

# build data
VERSION="2.14.2";
DIST_URL="https://www.freedesktop.org/software/fontconfig/release/fontconfig-${VERSION}.tar.gz";
APP_NAME="fontconfig";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--enable-libxml2 \
--with-arch=arm \
FREETYPE_CFLAGS="-I${BIN_DIR}/freetype/include/freetype2 -I${BIN_DIR}/libpng/include" \
FREETYPE_LIBS="-L${BIN_DIR}/freetype/lib -L${BIN_DIR}/libpng/lib -lfreetype -lpng16" \
LIBXML2_CFLAGS="-I${BIN_DIR}/libxml2/include/libxml2" \
LIBXML2_LIBS="-L${BIN_DIR}/libxml2/lib -lxml2 -lm" \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make V=1 || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
