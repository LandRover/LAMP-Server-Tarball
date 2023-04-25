#!/bin/bash

# build data
VERSION="2.7.0";
DIST_URL="https://dl.influxdata.com/influxdb/releases/influxdb2-client-${VERSION}-linux-amd64.tar.gz";
APP_NAME="influxdb2-client";

source ./helpers/build_pre/.pre-start.sh;

[ -d "${BIN_DIR}/${APP_NAME}-${VERSION}/bin" ] && echo "[INFO] Detected previous install of ${APP_NAME}, Version: ${VERSION}. Removing..." && rm -rf ${BIN_DIR}/${APP_NAME}-${VERSION};
mkdir -p ${BIN_DIR}/${APP_NAME}-${VERSION}/bin;
cp ../${APP_NAME}-${VERSION}/influx ${BIN_DIR}/${APP_NAME}-${VERSION}/bin/;

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
