#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(libxml2);

# build data
VERSION="1.1.34";
DIST_URL="http://xmlsoft.org/sources/libxslt-${VERSION}.tar.gz";
APP_NAME="libxslt";

source ./helpers/build_pre/.pre-start.sh;

export CFLAGS="-I${BIN_DIR}/libxml2/include";
export LDFLAGS="-L${BIN_DIR}/libxml2/lib";

./configure \
--prefix=${DESTINATION} \
--with-libxml-prefix=${BIN_DIR}/libxml2;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
