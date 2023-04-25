#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib);

# build data
VERSION="1.6.39";
DIST_URL="https://netix.dl.sourceforge.net/project/libpng/libpng16/${VERSION}/libpng-${VERSION}.tar.gz";
APP_NAME="libpng";

source ./helpers/build_pre/.pre-start.sh;

export CPPFLAGS="-I${BIN_DIR}/zlib/include";
export LDFLAGS="-L${BIN_DIR}/zlib/lib";

./configure \
--prefix=${DESTINATION} \
--with-zlib-prefix=${BIN_DIR}/zlib \
--disable-static \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
