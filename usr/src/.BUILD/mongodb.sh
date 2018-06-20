#!/bin/bash

## boost libs for c++
apt-get -y install libboost-filesystem-dev \
libboost-program-options-dev \
libboost-system-dev \
libboost-thread-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(scons);

# build data
BUILD="../${PWD##*/}";
VERSION="r3.6.5";
DIST_URL="http://downloads.mongodb.org/src/mongodb-src-${VERSION}.tar.gz";
APP_NAME="mongodb";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

## wierd notation by mongo.. with the src thing in name
rm -rf ../${APP_NAME}-${VERSION}; ln -s /usr/src/${APP_NAME}-src-${VERSION}/ /usr/src/${APP_NAME}-${VERSION};

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

scons -j 4 --64 --ssl all;
scons -j 4 --64 --ssl --prefix=${DESTINATION} install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};