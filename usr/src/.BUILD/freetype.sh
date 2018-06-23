#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(libpng);

# build data
VERSION="2.7.1";
DIST_URL="http://download.savannah.gnu.org/releases/freetype/freetype-${VERSION}.tar.gz";
APP_NAME="freetype";

source ./helpers/build_pre/.pre-start.sh;

export LIBPNG_LIBS="-L${BIN_DIR}/libpng/lib";
export LIBPNG_CFLAGS="-I${BIN_DIR}/libpng/include";

./autogen.sh;

./configure \
--prefix=${DESTINATION} \
--with-png=yes;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
