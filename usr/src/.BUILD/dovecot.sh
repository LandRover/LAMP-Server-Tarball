#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl zlib);

# build data
VERSION="2.3.10";
DIST_URL="https://dovecot.org/releases/2.3/dovecot-${VERSION}.tar.gz";
APP_NAME="dovecot";
USER="mail";

source ./helpers/build_pre/.pre-start.sh;

## Create user for exim
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

## SSL cert: https://support.plesk.com/hc/en-us/articles/115001833974-How-to-generate-custom-self-signed-SSL-certificates-and-apply-it-to-Dovecot-on-Plesk-for-Linux | https://wiki.dovecot.org/SSL/DovecotConfiguration

apt-get -y install libpam-dev;

export CFLAGS="-I${BIN_DIR}/openssl/include -I${BIN_DIR}/zlib/include";
export LDFLAGS="-L${BIN_DIR}/openssl/lib -L${BIN_DIR}/zlib/lib";

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR} \
--localstatedir=/var \
--with-systemdsystemunitdir=${ETC_DIR}/systemd/system \
--disable-largefile \
--with-zlib \
--without-icu;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};