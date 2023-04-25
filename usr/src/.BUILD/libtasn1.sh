#!/bin/bash

# build data
VERSION="4.19.0";
DIST_URL="https://ftp.gnu.org/gnu/libtasn1/libtasn1-${VERSION}.tar.gz";
APP_NAME="libtasn1";

source ./helpers/build_pre/.pre-start.sh;

# apt-get install texinfo

./configure \
--prefix=${DESTINATION} \
--disable-static \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
