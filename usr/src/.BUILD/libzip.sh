#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(cmake zlib);

# build data
VERSION="1.11.4";
DIST_URL="https://libzip.org/download/libzip-${VERSION}.tar.gz";
APP_NAME="libzip";

source ./helpers/build_pre/.pre-start.sh;

rm -rf build && mkdir -p build;
cd build;

cmake .. \
-DCMAKE_INSTALL_PREFIX=${DESTINATION} \
-DENABLE_OPENSSL=1 \
-DENABLE_GNUTLS=OFF \
-DENABLE_LZMA=OFF \
-DENABLE_BZIP2=OFF \
-DZLIB_LIBRARY=${BIN_DIR}/zlib/lib/libz.so \
-DZLIB_INCLUDE_DIR=${BIN_DIR}/zlib/include \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make -j ${CPU_CORES} || die 0 "[${APP_NAME}] Make failed";

echo "Installing ${APP_NAME}-${VERSION}..."
make test || die 0 "[${APP_NAME}] Make test failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}. It is recommended to reinstall libxslt after update of ${APP_NAME}.";

cd ..;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
