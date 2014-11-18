#!/bin/sh

VERSION="5.6.21";
APP_NAME="mysql";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

#http://zetcode.com/databases/mysqltutorial/installation/
#http://alinux.web.id/2011/08/14/compiling-mysql-5.5.12-with-cmake-on-centos.html

##add to startup @ redhat:
##chkconfig --add mysqld

rm -rf CMakeCache.txt;

cmake -DCMAKE_INSTALL_PREFIX=${OPT}/${APP_NAME}-${VERSION};
make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};