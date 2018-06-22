#!/bin/bash

USER="${PARAM1}";
DEFAULT_HOST_USER="defaulthost";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

## general init.d settings
../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}/bin/apachectl ${ETC_DIR}/init.d/${APP_NAME};

## I like getting there faster..
../helpers/bin/ln.sh ${APP_DIR}/htdocs /var/www;

## logs
../helpers/bin/ln.sh ${APP_DIR}/logs /var/log/httpd;

## create vhost + php-fpm settings for first hold
../helpers/apache_useradd.sh ${DEFAULT_HOST_USER} localhost 000 ${BIN_DIR}/${APP_NAME}/htdocs;

## create and own logs for vhosts
[ ! -d "/var/log/${USER}" ] && mkdir /var/log/${USER} && chown ${USER}:${USER} /var/log/${USER};

## security modes and owner changes from root
chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME};
chown -R ${USER}:${USER} ${APP_DIR};
chmod -R go-rwx ${APP_DIR};
chmod -R a-w ${APP_DIR};
chmod o+x ${APP_DIR} ${APP_DIR}/htdocs ${APP_DIR}/cgi-bin;
chmod -R o+r ${APP_DIR}/htdocs;
chmod -R u+w ${APP_DIR}/logs;

## restart service
/etc/init.d/${APP_NAME} restart