#!/bin/bash

# build data
VERSION="2.70";
DIST_URL="https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${VERSION}.tar.gz";
APP_NAME="libcap";

source ./helpers/build_pre/.pre-start.sh;

make prefix=${DESTINATION} \
RAISE_SETFCAP=no \
install || die 0 "[${APP_NAME}] Make install failed";

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
