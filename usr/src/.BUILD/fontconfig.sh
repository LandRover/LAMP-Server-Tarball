#!/bin/bash

## libs required
apt-get -y install gperf \
uuid-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(freetype libxml2);

# build data
VERSION="2.13.0";
DIST_URL="https://www.freedesktop.org/software/fontconfig/release/fontconfig-${VERSION}.tar.gz";
APP_NAME="fontconfig";

source ./helpers/build_pre/.pre-start.sh;

#export FREETYPE_CFLAGS='-I${BIN_DIR}/freetype/include/freetype2';
#export FREETYPE_LIBS='-L${BIN_DIR}/freetype/lib';
#export LIBXML2_CFLAGS='-I${BIN_DIR}/libxml2/include/libxml2';
#export LIBXML2_LIBS='-L${BIN_DIR}/libxml2';

./configure \
--prefix=${DESTINATION} \
--enable-libxml2 \
--with-arch=arm \
FREETYPE_CFLAGS="-I${BIN_DIR}/freetype/include/freetype2" \
FREETYPE_LIBS="-L${BIN_DIR}/freetype/lib -lfreetype" \
LIBXML2_CFLAGS="-I${BIN_DIR}/libxml2/include/libxml2" \
LIBXML2_LIBS="-L${BIN_DIR}/libxml2/lib -lxml2 -lm";

make V=1;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};