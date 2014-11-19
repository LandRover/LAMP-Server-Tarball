#!/bin/bash

VERSION="2.4.10";
APP_NAME="httpd";
OPT="/opt/local/sbin";
USER="apache";

cd ../${APP_NAME};

make clean;

groupadd ${USER};
useradd -d /opt/local/sbin/httpd/htdocs -g ${USER} -s /bin/false ${USER};

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--disable-alias \
--disable-setenvif \
--enable-deflate \
--enable-dir \
--enable-expires \
--enable-headers \
--enable-info \
--enable-mime-magic \
--enable-mods-shared='authz_core authz_host authz_basic suexec headers proxy status info mime deflate rewrite dir slotmem_shm ssl unique_id' \
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
--sysconfdir=/opt/local/etc/apache \
--with-apr-util=/opt/local/sbin/apr-util \
--with-apr=/opt/local/sbin/apr \
--with-expat=builtin \
--with-pcre=/opt/local/sbin/pcre \
--with-ssl=/opt/local/sbin/openssl \
--with-suexec \
--with-suexec-caller=${USER} \
--with-suexec-docroot=/opt/local/sbin/httpd/htdocs \
--with-suexec-gidmin=100 \
--with-suexec-logfile=/var/log/httpd/suexec_log \
--with-suexec-uidmin=100 \
--with-suexec-userdir=public_html;

make;
make install;

##chkconfig httpd on --level 2,3,5

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};

rm -rf /opt/local/etc/init.d/${APP_NAME}
ln -s ${OPT}/${APP_NAME}/bin/apachectl /opt/local/etc/init.d/${APP_NAME};

chown -R ${USER}:${USER} ${OPT}/${APP_NAME}
chmod -R go-rwx ${OPT}/${APP_NAME}
chmod -R r-w ${OPT}/${APP_NAME}
chmod o+x ${OPT}/${APP_NAME} ${OPT}/${APP_NAME}/htdocs ${OPT}/${APP_NAME}/cgi-bin
chmod -R o+r ${OPT}/${APP_NAME}/htdocs
chmod -R u+w ${OPT}/${APP_NAME}/logs
