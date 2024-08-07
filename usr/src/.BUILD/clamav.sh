#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(cmake rust cargo);

# build data
VERSION="1.3.1";
DIST_URL="https://github.com/Cisco-Talos/clamav/releases/download/clamav-${VERSION}/clamav-${VERSION}.tar.gz";
APP_NAME="clamav";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for clamav
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

rm -rf build && mkdir build && cd build;

cmake .. \
  -DCMAKE_PREFIX_PATH="${DESTINATION}" \
  -DAPP_CONFIG_DIRECTORY=${ETC_DIR}/clamav \
  -DDATABASE_DIRECTORY=/var/lib/clamav \
  -DENABLE_JSON_SHARED=OFF \
|| die 0 "[${APP_NAME}] Configure failed";

#./configure \
#--prefix=${DESTINATION} \
#--sysconfdir=${ETC_DIR} \
#CFLAGS="-I${BIN_DIR}/openssl/include" \
#LDFLAGS="-L${BIN_DIR}/openssl/lib64" \
#--disable-largefile \
#--with-pcre=${BIN_DIR}/pcre2 \
#--with-zlib=${BIN_DIR}/zlib \
#--with-xml=${BIN_DIR}/libxml2 \
#--with-libcurl=${BIN_DIR}/curl \
#--with-openssl=${BIN_DIR}/openssl \
#|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ..;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
