#!/bin/sh

cd ../apr-util;

./configure \
--prefix=/opt/local/sbin/apr-util-1.5.4 \
--with-apr=/opt/local/sbin/apr;

rm -rf /opt/local/sbin/apr-util;
ln -s /opt/local/sbin/apr-util-1.5.4 /opt/local/sbin/apr-util;

make;
make install;