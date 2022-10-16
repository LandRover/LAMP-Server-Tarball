#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(milter-manager);

# build data
VERSION="1.3.2";
DIST_URL="https://netix.dl.sourceforge.net/project/opendmarc/opendmarc-${VERSION}.tar.gz";
APP_NAME="opendmarc";

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
