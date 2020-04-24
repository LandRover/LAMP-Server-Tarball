#!/bin/bash

# build data
VERSION="9d";
DIST_URL="http://www.ijg.org/files/jpegsrc.v${VERSION}.tar.gz";
APP_NAME="jpeg";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--enable-shared \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
