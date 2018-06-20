#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="1.67.0";
DIST_URL="https://dl.bintray.com/boostorg/release/${VERSION}/source/boost_1_67_0.tar.gz";
APP_NAME="boost";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
SRC_DIR="/usr/src";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

## no compilation require, just a link for sbin
./${BUILD}/helpers/bin/ln.sh ${SRC_DIR}/${APP_NAME} ${BIN_DIR}/${APP_NAME};

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};
