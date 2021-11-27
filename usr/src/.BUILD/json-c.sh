#!/bin/bash

# build data
VERSION="0.15-20200726";
DIST_URL="https://github.com/json-c/json-c/archive/refs/tags/json-c-${VERSION}.tar.gz";
APP_NAME="json-c";

./helpers/bin/ln.sh /usr/src/${APP_NAME}-${APP_NAME}-${VERSION} /usr/src/${APP_NAME}-${VERSION};

source ./helpers/build_pre/.pre-start.sh;

mkdir build;
cd build;

../cmake-configure \
--prefix=${DESTINATION} \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
