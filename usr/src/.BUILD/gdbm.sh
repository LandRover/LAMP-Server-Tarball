#!/bin/bash

# build data
VERSION="1.18";
DIST_URL="ftp://ftp.gnu.org/gnu/gdbm/gdbm-${VERSION}.tar.gz";
APP_NAME="gdbm";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--disable-static \
--enable-libgdbm-compat;

make;
make check;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
