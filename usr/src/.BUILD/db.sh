#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="6.2.32";
DIST_URL="http://download.oracle.com/berkeley-db/db-${VERSION}.tar.gz";
APP_NAME="db";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./dist/configure \
--prefix=${DESTINATION} \
--enable-compat185 \
--enable-dbm \
--disable-static \
--enable-cxx;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};