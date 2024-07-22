#!/bin/bash

# build data
VERSION="1.94.5";
DIST_URL="https://github.com/Distrotech/majordomo/archive/refs/tags/distrotech-majordomo-${VERSION}.tar.gz";
APP_NAME="majordomo";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

make \
DESTDIR="${DESTINATION}" \
install || die 0 "[${APP_NAME}] Make install failed";

# Move all to upper path
mv ${DESTINATION}/opt/majordomo/* ${DESTINATION} && rm -rf ${DESTINATION}/opt/majordomo;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
