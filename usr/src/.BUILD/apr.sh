#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="1.6.3";
DIST_URL="http://apache.spd.co.il/apr/apr-${VERSION}.tar.gz";
APP_NAME="apr";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};