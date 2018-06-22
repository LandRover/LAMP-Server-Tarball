#!/bin/bash

# build data
VERSION="1.2.11";
DIST_URL="https://zlib.net/zlib-${VERSION}.tar.gz";
APP_NAME="zlib";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
