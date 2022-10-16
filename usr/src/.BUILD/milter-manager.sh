#!/bin/bash

apt-get install -y ruby-gnome-dev

# build data
VERSION="2.1.5";
DIST_URL="https://github.com/milter-manager/milter-manager/archive/refs/tags/${VERSION}.tar.gz";
APP_NAME="milter-manager";

source ./helpers/build_pre/.pre-start.sh;

./autogen.sh \
--prefix=${DESTINATION} \
|| die 0 "[${APP_NAME}] autogen failed";

./configure \
--prefix=${DESTINATION} \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
