#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(libxml2 libgcrypt);

# build data
VERSION="1.1.34";
DIST_URL="http://xmlsoft.org/sources/libxslt-${VERSION}.tar.gz";
APP_NAME="libxslt";

source ./helpers/build_pre/.pre-start.sh;

export LIBGCRYPT_CFLAGS="-I${BIN_DIR}/libgcrypt/include";
export LIBGCRYPT_LIBS="-L${BIN_DIR}/libgcrypt/lib";

./configure \
--prefix=${DESTINATION} \
--enable-static \
--without-python \
--without-crypto \
--with-libxml-src=../libxml2 \
--with-libxml-prefix=${BIN_DIR}/libxml2/bin \
--with-libxml-include-prefix=${BIN_DIR}/libxml2/include/libxml2 \
--with-libxml-libs-prefix=${BIN_DIR}/libxml2/lib \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
