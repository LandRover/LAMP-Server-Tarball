#!/bin/bash

# build data
VERSION="4.0.0";
DIST_URL="https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-${VERSION}.tar.gz";
APP_NAME="mpdecimal";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
