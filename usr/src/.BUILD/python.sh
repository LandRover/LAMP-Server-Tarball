#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl mpdecimal);

# build data
VERSION="3.12.4";
DIST_URL="https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz";
APP_NAME="python";

source ./helpers/build_pre/.pre-start.sh;


export CFLAGS="-I${BIN_DIR}/mpdecimal/include";
export LDFLAGS="-L${BIN_DIR}/mpdecimal/lib";

./configure \
--prefix=${DESTINATION} \
LDFLAGS="-L${BIN_DIR}/openssl/lib64" \
INCLUDES="-I${BIN_DIR}/openssl/include" \
--enable-ipv6 \
--enable-shared \
--enable-optimizations \
--enable-loadable-sqlite-extensions \
--with-computed-gotos \
--with-dbmliborder=bdb:gdbm \
--with-openssl="${BIN_DIR}/openssl" \
--with-openssl-rpath=auto \
--with-system-expat \
--with-system-ffi \
--with-system-libmpdec \
--with-lto \
--without-ensurepip \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
