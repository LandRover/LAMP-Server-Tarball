#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(apr);

# build data
BUILD="../${PWD##*/}";
VERSION="1.6.1";
DIST_URL="http://apache.spd.co.il/apr/apr-util-${VERSION}.tar.gz";
APP_NAME="apr-util";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./configure \
--prefix=${DESTINATION} \
--with-apr=${BIN_DIR}/apr;

make;
make install;

[ -f "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};
