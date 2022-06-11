#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(arp arp-util pcre openssl php);

# build data
VERSION="2.4.54";
DIST_URL="https://dlcdn.apache.org/httpd/httpd-${VERSION}.tar.gz";
APP_NAME="httpd";
USER="apache";
HOME_DIR="/home/${USER}";

source ./helpers/build_pre/.pre-start.sh;

[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && mkdir -p ${HOME_DIR}/public_html && useradd -M -s /bin/false -d ${HOME_DIR}/public_html ${USER};

./configure \
--prefix=${DESTINATION} \
--disable-alias \
--enable-deflate \
--enable-dir \
--enable-expires \
--enable-headers \
--enable-info \
--enable-mime-magic \
--enable-mods-shared='authn_core authn_file authz_core authz_host authz_user auth_basic suexec headers proxy status info mime deflate rewrite dir slotmem_shm ssl setenvif unique_id filter request expires log_config' \
--enable-mods-static='unixd' \
--enable-modules='none' \
--enable-mpms-shared='event worker' \
--enable-proxy \
--enable-rewrite \
--enable-slotmem-shm \
--enable-so \
--enable-ssl \
--enable-http2 \
--enable-status \
--enable-suexec \
--enable-unique-id \
--enable-unixd \
--enable-vhost-alias \
--sysconfdir=${ETC_DIR}/apache \
--with-apr-util=${BIN_DIR}/apr-util \
--with-apr=${BIN_DIR}/apr \
--with-expat=builtin \
--with-pcre=${BIN_DIR}/pcre \
--with-ssl=${BIN_DIR}/openssl \
--with-z=${BIN_DIR}/zlib \
--with-suexec \
--with-suexec-caller=${USER} \
--with-suexec-docroot=${HOME_DIR}/public_html \
--with-suexec-gidmin=100 \
--with-suexec-logfile=${HOME_DIR}/logs/suexec_log \
--with-suexec-uidmin=100 \
--with-suexec-userdir=public_html \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

##chkconfig httpd on --level 2,3,5

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
