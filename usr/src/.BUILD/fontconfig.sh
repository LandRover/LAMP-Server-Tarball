#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="2.11.1";
APP_NAME="fontconfig";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

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

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};