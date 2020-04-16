#!/bin/bash

# build data
VERSION="1.2.10";
DIST_URL="https://www.libspf2.org/spf/libspf2-${VERSION}.tar.gz";
APP_NAME="libspf2";

source ./helpers/build_pre/.pre-start.sh;

COMPILE_FROM_SOURCE=false;

[ "$COMPILE_FROM_SOURCE" != true ] && apt-get -y install spf-tools-perl;

## pending pull request fix: https://github.com/shevek/libspf2/pull/5/files
## won't compile without.
## sed 's/SPF_debugx( __FILE__, __LINE__, format, __VA_ARGS__ )/SPF_debugx( __FILE__, __LINE__, format, ##__VA_ARGS__ )/g' /usr/src/libspf2/src/include/spf_log.h
## --host/--build set to 'x86_64-linux-gnu'

./configure \
--prefix=${DESTINATION};

make;
make check;
make install;
#make maintainer-clean;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
