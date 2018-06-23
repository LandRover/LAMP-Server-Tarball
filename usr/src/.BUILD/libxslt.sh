#!/bin/bash

# build data
VERSION="1.1.30"; ## latest - 1.1.31+1.1.32 does not compile well, throws: recipe for target 'xsltproc' failed
DIST_URL="http://xmlsoft.org/sources/libxslt-${VERSION}.tar.gz";
APP_NAME="libxslt";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--with-libxml-prefix=${BIN_DIR}/libxml2 \
--with-libxml-libs-prefix=${BIN_DIR}/libxml2/lib \
--with-libxml-include-prefix=${BIN_DIR}/libxml2/include/libxml2;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
