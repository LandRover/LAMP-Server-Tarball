#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(libtasn1 libffi);

# build data
VERSION="0.25.5";
DIST_URL="https://github.com/p11-glue/p11-kit/releases/download/${VERSION}/p11-kit-${VERSION}.tar.xz";
APP_NAME="p11-kit";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--with-system-config=${ETC_DIR}/pkcs11 \
CFLAGS="-I${BIN_DIR}/libtasn1/include -I${BIN_DIR}/libffi/include" \
LIBTASN1_CFLAGS="-I${BIN_DIR}/libtasn1/include" \
LIBTASN1_LIBS="-L${BIN_DIR}/libtasn1/lib -ltasn1" \
LIBFFI_CFLAGS="-I${BIN_DIR}/libffi/include" \
LIBFFI_LIBS="-L${BIN_DIR}/libffi/lib -lffi" \
--with-libffi \
--with-trust-paths="${ETC_DIR}/pki/anchors" \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
