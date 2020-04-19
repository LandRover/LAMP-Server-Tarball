#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(libidn2 libtasn1 libunistring gmp nettle);

# build data
VERSION="3.6.13";
DIST_URL="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-${VERSION}.tar.xz";
APP_NAME="gnutls";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
CFLAGS="-I${BIN_DIR}/libunistring/include -I${BIN_DIR}/libidn2/include -I${BIN_DIR}/libtasn1/include -I${BIN_DIR}/nettle/include" \
LDFLAGS="-L${BIN_DIR}/libunistring/lib -L${BIN_DIR}/libidn2/lib -L${BIN_DIR}/libtasn1/lib -L${BIN_DIR}/nettle/lib64 -lnettle" \
GMP_CFLAGS="-I${BIN_DIR}/gmp/include" \
GMP_LIBS="-L${BIN_DIR}/gmp/lib" \
NETTLE_CFLAGS="-I${BIN_DIR}/nettle/include" \
NETTLE_LIBS="-L${BIN_DIR}/nettle/lib64" \
HOGWEED_CFLAGS="-I${BIN_DIR}/nettle/include" \
HOGWEED_LIBS="-L${BIN_DIR}/nettle/lib64" \
--with-idn \
--enable-fips140-mode \
--with-included-libtasn1 \
--disable-non-suiteb-curves;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
