#!/bin/bash

apt-get -y install libpcre3-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(php);

VERSION="5.1.22";
DIST_URL="https://pecl.php.net/get/apcu-${VERSION}.tgz";
APP_NAME="apcu";

source ./helpers/build_pre/.pre-start.sh;

${BIN_DIR}/php/bin/phpize;

./configure \
--with-php-config=${BIN_DIR}/php/bin/php-config \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
