#!/bin/bash

# build data
VERSION="6.2.32";
DIST_URL="http://download.oracle.com/berkeley-db/db-${VERSION}.tar.gz";
APP_NAME="db";

source ./helpers/build_pre/.pre-start.sh;

./dist/configure \
--prefix=${DESTINATION} \
--enable-compat185 \
--enable-dbm \
--disable-static \
--enable-cxx;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};