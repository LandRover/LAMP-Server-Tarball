#!/bin/bash

## general init.d settings
mkdir -p ${BIN_DIR}/${APP_NAME}/init.d;
cp /usr/src/fail2ban/files/debian-initd ${BIN_DIR}/${APP_NAME}/init.d/${APP_NAME};
../../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}/init.d/${APP_NAME} ${ETC_DIR}/init.d/${APP_NAME};

perl -pi -e "s|\/usr\/local\/bin|${BIN_DIR}\/${APP_NAME}\/bin|g" ${BIN_DIR}/${APP_NAME}/init.d/${APP_NAME};

# add to global python3 require path
ln -s ${BIN_DIR}/${APP_NAME}/lib/python/${APP_NAME} /usr/lib/python3/dist-packages/${APP_NAME};

# auto start
update-rc.d ${APP_NAME} defaults
