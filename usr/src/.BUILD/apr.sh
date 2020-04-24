#!/bin/bash

# build data
VERSION="1.7.0";
DIST_URL="http://apache.spd.co.il/apr/apr-${VERSION}.tar.gz";
APP_NAME="apr";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
CFLAGS="-I${BIN_DIR}/pcre2/include" \
LDFLAGS="-lpcre2-8 -L${BIN_DIR}/pcre2/lib" \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
