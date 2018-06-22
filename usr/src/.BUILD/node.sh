#!/bin/bash

# build data
VERSION="v10.4.1";
DIST_URL="https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz";
APP_NAME="node";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};