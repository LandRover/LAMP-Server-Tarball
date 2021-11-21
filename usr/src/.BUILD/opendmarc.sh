#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(milter-manager);

# build data
VERSION="1.3.2";
DIST_URL="https://netix.dl.sourceforge.net/project/opendmarc/opendmarc-${VERSION}.tar.gz";
APP_NAME="opendmarc";

source ./helpers/build_pre/.pre-start.sh;

COMPILE_FROM_SOURCE=false;

[ "$COMPILE_FROM_SOURCE" != true ] && apt-get -y install libopendmarc-dev;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
