#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(libedit Linux-PAM openssl zlib);

# build data
VERSION="10.0";
DIST_URL="https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${VERSION}.tar.gz";
APP_NAME="openssh";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR}/${APP_NAME} \
--with-cflags="-I${BIN_DIR}/Linux-PAM/include -I${BIN_DIR}/libedit/include -I${BIN_DIR}/zlib/include" \
--with-ldflags="-L${BIN_DIR}/Linux-PAM/lib -L${BIN_DIR}/libedit/lib" \
--disable-etc-default-login \
--with-4in6 \
--with-pam \
--with-selinux \
--with-privsep-path=/run/sshd \
--with-pid-dir=/var/run/ \
--with-pid-dir=/run \
--with-lastlog=/var/log/ \
--with-xauth=/usr/bin/xauth \
--with-libedit \
--with-ssl-dir=${BIN_DIR}/openssl \
--with-zlib=${BIN_DIR}/zlib/lib \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
