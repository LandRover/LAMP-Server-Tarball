#!/bin/bash

# build data
VERSION="0.102.2";
DIST_URL="https://www.clamav.net/downloads/production/clamav-${VERSION}.tar.gz";
APP_NAME="clamav";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for exim
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

export CFLAGS="-I${BIN_DIR}/openssl/include";
export LDFLAGS="-L${BIN_DIR}/openssl/lib";

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR} \
--disable-largefile \
--with-pcre=${BIN_DIR}/pcre2 \
--with-zlib=${BIN_DIR}/zlib \
--with-xml=${BIN_DIR}/libxml2 \
--with-libcurl=${BIN_DIR}/curl \
--with-openssl=${BIN_DIR}/openssl;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
