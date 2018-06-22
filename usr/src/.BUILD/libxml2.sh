#!/bin/bash

# build data
VERSION="2.9.8";
DIST_URL="http://xmlsoft.org/sources/libxml2-${VERSION}.tar.gz";
APP_NAME="libxml2";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};