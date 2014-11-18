#!/bin/bash

cd ../suphp;

## version 0.7.1 does not support apache 2.4.X

./configure \
--prefix=/opt/local/sbin/suphp-0.7.1 \
#--with-apxs=/opt/local/sbin/httpd/bin/apxs \
--with-apache-user=daemon \
--with-logfile=/opt/local/sbin/httpd/logs/suphp_log \
--with-setid-mode=paranoid \
--sysconfdir=/etc \
--with-apr=/opt/local/sbin/apr \
--enable-suphp_USE_USERGROUP=yes;

make;
make install;