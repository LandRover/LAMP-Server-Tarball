#!/bin/bash

# build data
VERSION="1.65.0";
DIST_URL="https://github.com/nghttp2/nghttp2/releases/download/v${VERSION}/nghttp2-${VERSION}.tar.gz";
APP_NAME="nghttp2";

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
