#!/bin/sh

cd ../httpd;

#apt-get install make autoconf automake1.9 libmysqlclient15-dev libtool libssl-dev gcc-4.1 g++ libnet1 libpcap0.8 libpcap0.8-dev

make clean;

./configure \
--prefix=/local/sbin/httpd-2.4.3 \
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
--with-ssl=/local/sbin/openssl \
--with-apr=/local/sbin/apr \
--with-apr-util=/local/sbin/apr-util \
--with-pcre=/local/sbin/pcre \
--with-expat=builtin \
--sysconfdir=/etc/apache;

make;
make install;

##chkconfig httpd on --level 2,3,5