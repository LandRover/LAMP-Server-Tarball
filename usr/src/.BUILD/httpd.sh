#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(arp arp-util pcre openssl);

# build data
BUILD="../${PWD##*/}";
VERSION="2.4.17";
APP_NAME="httpd";
USER="apache";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d ${BIN_DIR}/httpd/htdocs ${USER};

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
--with-suexec-docroot=${BIN_DIR}/httpd/htdocs \
--with-suexec-gidmin=100 \
--with-suexec-logfile=${BIN_DIR}/httpd/logs/suexec_log \
--with-suexec-uidmin=100 \
--with-suexec-userdir=public_html;

make;
make install;

##chkconfig httpd on --level 2,3,5

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};
