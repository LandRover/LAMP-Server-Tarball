#!/bin/bash

cd ../libxml2;

./configure \
--prefix=/opt/local/sbin/libxml2-2.9.0;

make;
make install;