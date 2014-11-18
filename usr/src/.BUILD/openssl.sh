#!/bin/bash

VERSION="1.0.1j";
APP_NAME="openssl";
OPT="/opt/local/sbin";

cd ../$(APP_NAME);

make clean;

./config \
--prefix=$(OPT)/$(APP_NAME)-$(VERSION) \
zlib-dynamic --openssldir=/etc/ssl zlib enable-tlsext shared;

make depend;
make;
make install;

/sbin/ldconfig -v /opt/local/sbin/openssl/lib;

rm -rf $(OPT)/$(APP_NAME);
ln -s $(OPT)/$(APP_NAME)-$(VERSION) $(OPT)/$(APP_NAME);