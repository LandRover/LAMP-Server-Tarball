#!/bin/bash

# build data
VERSION="1.18.1";
DIST_URL="ftp://ftp.gnu.org/gnu/gdbm/gdbm-${VERSION}.tar.gz";
APP_NAME="gdbm";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--disable-static \
--enable-libgdbm-compat \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

echo "Testing make ${APP_NAME}...";
make check || die 0 "[${APP_NAME}] Make test failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
