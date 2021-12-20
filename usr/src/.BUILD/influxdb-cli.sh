#!/bin/bash

# build data
VERSION="2.2.1";
DIST_URL="https://dl.influxdata.com/influxdb/releases/influxdb2-client-${VERSION}-linux-amd64.tar.gz";
APP_NAME="influxdb-cli";

source ./helpers/build_pre/.pre-start.sh;


echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
