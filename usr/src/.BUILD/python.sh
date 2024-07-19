#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl mpdecimal libexpat libffi);

# build data
VERSION="3.12.4";
DIST_URL="https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz";
APP_NAME="python";

source ./helpers/build_pre/.pre-start.sh;

export CFLAGS="-I${BIN_DIR}/mpdecimal/include";
export LDFLAGS="-L${BIN_DIR}/mpdecimal/lib";

./configure \
--prefix=${DESTINATION} \
INCLUDES="-I${BIN_DIR}/openssl/include" \
LDFLAGS="-L${BIN_DIR}/openssl/lib64" \
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
--with-computed-gotos \
--with-dbmliborder=bdb:gdbm \
--with-system-expat \
--with-openssl=${BIN_DIR}/openssl \
--with-openssl-rpath=auto \
--with-ssl-default-suites=openssl \
--with-lto \
--with-ensurepip=upgrade \
--with-fpectl=no \
--with-pydebug=no \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
