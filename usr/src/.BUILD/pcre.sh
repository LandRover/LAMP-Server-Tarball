#!/bin/bash

cd ../pcre;

./configure \
--prefix=/opt/local/sbin/pcre-8.31;

make;
make install;