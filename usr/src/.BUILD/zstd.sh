#!/bin/bash

# build data
VERSION="1.5.7";
DIST_URL="https://github.com/facebook/zstd/archive/refs/tags/v${VERSION}.tar.gz";
APP_NAME="zstd";

source ./helpers/build_pre/.pre-start.sh;

make \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make \
PREFIX=${DESTINATION} \
install || die 0 "[${APP_NAME}] Make install failed";

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
