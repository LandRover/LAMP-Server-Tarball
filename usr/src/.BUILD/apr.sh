#!/bin/bash

cd ../apr;

./configure \
--prefix=/opt/local/sbin/apr-1.5.1;

rm -rf /opt/local/sbin/apr;
ln -s /opt/local/sbin/apr-1.5.1 /opt/local/sbin/apr;

make;
make install;