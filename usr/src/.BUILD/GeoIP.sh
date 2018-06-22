#!/bin/bash

# build data
VERSION="1.6.12";
DIST_URL="https://github.com/maxmind/geoip-api-c/releases/download/v${VERSION}/GeoIP-${VERSION}.tar.gz";
APP_NAME="GeoIP";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};