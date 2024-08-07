#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(cmake);

# build data
VERSION="2.3.4";
DIST_URL="https://github.com/librsync/librsync/releases/download/v${VERSION}/librsync-${VERSION}.tar.gz";
APP_NAME="librsync";

source ./helpers/build_pre/.pre-start.sh;

cmake \
-DCMAKE_INSTALL_PREFIX="${DESTINATION}" \
-DBUILD_SHARED_LIBS=OFF \
-DBUILD_RDIFF=OFF . \
|| die 0 "[${APP_NAME}] Configure failed";


echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
