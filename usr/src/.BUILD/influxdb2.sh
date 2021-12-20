#!/bin/bash

# build data
VERSION="2.1.1";
DIST_URL="https://github.com/influxdata/influxdb/archive/refs/tags/v${VERSION}.tar.gz";
APP_NAME="influxdb2";

source ./helpers/build_pre/.pre-start.sh;

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
