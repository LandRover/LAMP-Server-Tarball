#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib jpeg libpng freetype fontconfig);

# build data
VERSION="2.3.0";
DIST_URL="https://github.com/libgd/libgd/releases/download/gd-${VERSION}/libgd-${VERSION}.tar.gz";
APP_NAME="libgd";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--with-zlib=${BIN_DIR}/zlib \
--with-jpeg=${BIN_DIR}/jpeg \
--with-png=${BIN_DIR}/libpng \
--without-x \
--without-xpm \
--with-fontconfig=${BIN_DIR}/fontconfig \
--with-freetype=${BIN_DIR}/freetype;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};