#!/bin/bash

# build data
VERSION="9d";
DIST_URL="http://www.ijg.org/files/jpegsrc.v${VERSION}.tar.gz";
APP_NAME="jpeg";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--enable-shared;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
