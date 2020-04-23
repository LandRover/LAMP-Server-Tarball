#!/bin/bash

# build data
VERSION="1.0";
DIST_URL="https://opsec.eu/src/srs/libsrs_alt-${VERSION}.tar.bz2";
APP_NAME="libsrs_alt";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
