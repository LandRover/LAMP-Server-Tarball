#!/bin/bash

## boost libs for c++
apt-get -y install libboost-filesystem-dev \
libboost-program-options-dev \
libboost-system-dev \
libboost-thread-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(scons);

# build data
VERSION="r6.0.5";
DIST_URL="https://fastdl.mongodb.org/src/mongodb-src-${VERSION}.tar.gz";
APP_NAME="mongodb";

## wierd notation by mongo.. with the src thing in name
rm -rf ../${APP_NAME}-${VERSION}; ln -s /usr/src/${APP_NAME}-src-${VERSION}/ /usr/src/${APP_NAME}-${VERSION};

source ./helpers/build_pre/.pre-start.sh;

echo "Trying to make ${APP_NAME}...";
scons -j 4 --64 --ssl all || die 0 "[${APP_NAME}] Make failed";

scons -j 4 --64 --ssl --prefix=${DESTINATION} install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
