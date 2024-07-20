#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(zlib mpdecimal libexpat libffi openssl);

# build data
VERSION="3.12.4";
DIST_URL="https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz";
APP_NAME="python";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
CFLAGS="-I${BIN_DIR}/openssl/include -I${BIN_DIR}/mpdecimal/include" \
LDFLAGS="-L${BIN_DIR}/openssl/lib64 -L${BIN_DIR}/mpdecimal/lib" \
LIBEXPAT_CFLAGS="-I${BIN_DIR}/libexpat/include" \
LIBEXPAT_LDFLAGS="-L${BIN_DIR}/libexpat/lib" \
LIBFFI_CFLAGS="-I${BIN_DIR}/libffi/include" \
LIBFFI_LIBS="-L${BIN_DIR}/libffi/lib" \
ZLIB_CFLAGS="-I${BIN_DIR}/zlib/include" \
ZLIB_LIBS="-L${BIN_DIR}/zlib/lib" \
--disable-test-modules \
--enable-ipv6 \
--enable-shared \
--enable-optimizations \
--enable-loadable-sqlite-extensions \
--enable-big-digits=30 \
--enable-profiling \
--with-lto \
--with-computed-gotos \
--with-system-ffi \
--with-system-expat \
--with-system-libmpdec \
--with-dbmliborder=bdb:gdbm \
--with-openssl-rpath=auto \
--with-ssl-default-suites=openssl \
--with-openssl=${BIN_DIR}/openssl \
--with-fpectl=no \
--with-pydebug=no \
--with-ensurepip=upgrade \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
