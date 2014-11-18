#!/bin/bash

cd ../openssl;

make clean;

./config --prefix=/opt/local/sbin/openssl-1.0.1c \
zlib-dynamic --openssldir=/etc/ssl zlib enable-tlsext shared;

make depend;
make;
make install;

/sbin/ldconfig -v /opt/local/sbin/openssl/lib;