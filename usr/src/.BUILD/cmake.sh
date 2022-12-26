#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
VERSION="3.25.1";
DIST_URL="https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}.tar.gz";
APP_NAME="cmake";

source ./helpers/build_pre/.pre-start.sh;

export OPENSSL_ROOT_DIR="${BIN_DIR}/openssl";
export OPENSSL_INCLUDE_DIR="${BIN_DIR}/openssl/include";
export OPENSSL_LIBRARIES="${BIN_DIR}/openssl/lib64";
export OPENSSL_CRYPTO_LIBRARY="${BIN_DIR}/openssl/lib64/libcrypto.so";

./bootstrap \
  --verbose \
  --parallel=$(nproc) \
  --prefix=${DESTINATION} \
  -- \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_PREFIX_PATH="${DESTINATION}" \
  -DCMAKE_USE_OPENSSL="ON" \
|| die 0 "[${APP_NAME}] Configure failed";

make -C ${APP_NAME}-${VERSION} -j $(nproc);
make -C ${APP_NAME}-${VERSION} -j $(nproc) install;

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
