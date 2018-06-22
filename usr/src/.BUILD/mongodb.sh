#!/bin/bash

## boost libs for c++
apt-get -y install libboost-filesystem-dev \
libboost-program-options-dev \
libboost-system-dev \
libboost-thread-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(scons);

# build data
VERSION="r3.6.5";
DIST_URL="http://downloads.mongodb.org/src/mongodb-src-${VERSION}.tar.gz";
APP_NAME="mongodb";

## wierd notation by mongo.. with the src thing in name
rm -rf ../${APP_NAME}-${VERSION}; ln -s /usr/src/${APP_NAME}-src-${VERSION}/ /usr/src/${APP_NAME}-${VERSION};

source ./helpers/build_pre/.pre-start.sh;

scons -j 4 --64 --ssl all;
scons -j 4 --64 --ssl --prefix=${DESTINATION} install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};