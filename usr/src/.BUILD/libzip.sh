#!/bin/bash

# build data
VERSION="1.6.1";
DIST_URL="https://libzip.org/download/libzip-${VERSION}.tar.gz";
APP_NAME="libzip";

source ./helpers/build_pre/.pre-start.sh;

cmake \
-DCMAKE_INSTALL_PREFIX=${DESTINATION} \
-DENABLE_OPENSSL=1 \
-DZLIB_LIBRARY=${BIN_DIR}/zlib/lib \
-DZLIB_INCLUDE_DIR=${BIN_DIR}/zlib/include;

make;
make test;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
