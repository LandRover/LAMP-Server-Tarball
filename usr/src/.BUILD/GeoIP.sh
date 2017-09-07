#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="1.6.11";
DIST_URL="https://github.com/maxmind/geoip-api-c/releases/download/v${VERSION}/GeoIP-${VERSION}.tar.gz";
APP_NAME="GeoIP";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./configure \
--prefix=${DESTINATION};

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};