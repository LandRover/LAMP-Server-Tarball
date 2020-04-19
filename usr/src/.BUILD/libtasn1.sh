#!/bin/bash

# build data
VERSION="4.16.0";
DIST_URL="https://ftp.gnu.org/gnu/libtasn1/libtasn1-${VERSION}.tar.gz";
APP_NAME="libtasn1";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
