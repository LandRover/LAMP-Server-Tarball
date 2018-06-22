#!/bin/bash

# build data
VERSION="2.7";
DIST_URL="https://github.com/gperftools/gperftools/releases/download/gperftools-${VERSION}/gperftools-${VERSION}.tar.gz";
APP_NAME="gperftools";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--enable-frame-pointers;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};