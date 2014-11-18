#!/bin/bash

VERSION="0.72";
APP_NAME="suphp";
OPT="/opt/local/sbin";

cd ../$(APP_NAME);

make clean;

## version 0.7.1 does not support apache 2.4.X

./configure \
--prefix=$(OPT)/$(APP_NAME)-$(VERSION) \
#--with-apxs=/opt/local/sbin/httpd/bin/apxs \
--with-apache-user=daemon \
--with-logfile=/opt/local/sbin/httpd/logs/suphp_log \
--with-setid-mode=paranoid \
--sysconfdir=/etc \
--with-apr=/opt/local/sbin/apr \
--enable-suphp_USE_USERGROUP=yes;

make;
make install;

rm -rf $(OPT)/$(APP_NAME);
ln -s $(OPT)/$(APP_NAME)-$(VERSION) $(OPT)/$(APP_NAME);