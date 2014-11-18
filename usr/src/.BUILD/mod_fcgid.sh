#!/bin/sh

VERSION="2.3.9";
APP_NAME="mod_fcgid";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

APXS=/opt/local/sbin/httpd/bin/apxs ./configure.apxs;

make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};