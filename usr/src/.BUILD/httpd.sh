#!/bin/bash

VERSION="2.4.10";
APP_NAME="httpd";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

groupadd apache;
useradd -d /var/www/ -g apache -s /bin/false apache;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--enable-so \
--enable-ssl \
--enable-info \
--enable-cache \
--enable-file-cache \
--enable-disk-cache \
--enable-mem-cache \
--enable-expires \
--enable-headers \
--enable-proxy \
--enable-mime-magic \
--enable-vhost-alias \
--enable-usertrack \
--enable-deflate \
--enable-rewrite \
--enable-unique-id \
--enable-unixd \
--enable-mods-static='unixd' \
--enable-suexec \
--with-suexec \
--with-suexec-caller=apache \
--with-suexec-docroot=/var/www \
--with-suexec-logfile=/var/log/httpd/suexec_log \
--with-suexec-userdir=public_html \
--with-suexec-uidmin=100 \
--with-suexec-gidmin=100 \
--with-ssl=/opt/local/sbin/openssl \
--with-apr=/opt/local/sbin/apr \
--with-apr-util=/opt/local/sbin/apr-util \
--with-pcre=/opt/local/sbin/pcre \
--with-expat=builtin \
--sysconfdir=/opt/local/etc/apache;

make;
make install;

##chkconfig httpd on --level 2,3,5

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};

rm -rf /opt/local/etc/init.d/${APP_NAME}
ln -s ${OPT}/${APP_NAME}/bin/apachectl /opt/local/etc/init.d/${APP_NAME};