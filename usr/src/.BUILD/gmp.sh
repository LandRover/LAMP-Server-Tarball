#!/bin/bash

# build data
VERSION="6.2.0";
DIST_URL="https://gmplib.org/download/gmp/gmp-${VERSION}.tar.gz";
APP_NAME="gmp";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
