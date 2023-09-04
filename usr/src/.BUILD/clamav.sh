#!/bin/bash

# build data
VERSION="1.2.0";
DIST_URL="https://github.com/Cisco-Talos/clamav/releases/download/clamav-${VERSION}/clamav-${VERSION}.tar.gz";
APP_NAME="clamav";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for clamav
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR} \
CFLAGS="-I${BIN_DIR}/openssl/include" \
LDFLAGS="-L${BIN_DIR}/openssl/lib64" \
--disable-largefile \
--with-pcre=${BIN_DIR}/pcre2 \
--with-zlib=${BIN_DIR}/zlib \
--with-xml=${BIN_DIR}/libxml2 \
--with-libcurl=${BIN_DIR}/curl \
--with-openssl=${BIN_DIR}/openssl \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
