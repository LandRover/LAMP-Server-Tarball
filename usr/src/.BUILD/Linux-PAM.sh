#!/bin/bash

apt-get -y install libsystemd-dev libselinux1-dev;

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl zlib);

# build data
VERSION="1.6.1";
DIST_URL="https://github.com/linux-pam/linux-pam/releases/download/v${VERSION}/Linux-PAM-${VERSION}.tar.xz";
APP_NAME="Linux-PAM";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR}/${APP_NAME} \
--includedir="${DESTINATION}/include/security" \
--sbindir=/usr/sbin \
-libdir=/usr/lib \
--disable-prelude \
--disable-nis \
--enable-nls \
--enable-securedir=${DESTINATION}/security \
--enable-selinux \
--with-systemdunitdir=/usr/lib/systemd/system \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
