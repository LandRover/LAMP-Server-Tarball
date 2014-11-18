#!/bin/bash

cd ../mhash;

./configure \
--prefix=/opt/local/sbin/mhash-0.9.9.9;

make;
make install;