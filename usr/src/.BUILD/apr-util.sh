#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(apr);

# build data
VERSION="1.6.1";
DIST_URL="http://apache.spd.co.il/apr/apr-util-${VERSION}.tar.gz";
APP_NAME="apr-util";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--with-apr=${BIN_DIR}/apr \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};