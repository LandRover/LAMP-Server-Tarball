#!/bin/bash

apt-get -y install xutils-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib);

#http://curl.haxx.se/ca/cacert.pem --> /opt/local/etc/openssl/certs/cacert.pem

# build data
VERSION="1.1.1l";
DIST_URL="https://www.openssl.org/source/openssl-${VERSION}.tar.gz";
APP_NAME="openssl";

source ./helpers/build_pre/.pre-start.sh;

export CFLAGS="-fstack-protector-strong -Wformat -Werror=format-security";
export CPPFLAGS="-Wdate-time -D_FORTIFY_SOURCE=2";

./config \
--prefix=${DESTINATION} \
--openssldir=${ETC_DIR}/${APP_NAME} \
--with-zlib-lib=${BIN_DIR}/zlib/lib \
--with-zlib-include=${BIN_DIR}/zlib/include \
no-ssl \
zlib \
shared \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make depend ${APP_NAME}...";
make depend || die 0 "[${APP_NAME}] Make depend failed";

echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
