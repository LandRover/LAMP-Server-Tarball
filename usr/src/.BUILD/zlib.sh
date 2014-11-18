#!/bin/bash

cd ../zlib;

./configure \
--prefix=/usr/local/sbin/zlib-1.2.7;

make;
make install;