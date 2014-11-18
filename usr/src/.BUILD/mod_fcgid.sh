#!/bin/sh

cd ../mod_fcgid;

APXS=/opt/local/sbin/httpd/bin/apxs ./configure.apxs;

make;
make install;