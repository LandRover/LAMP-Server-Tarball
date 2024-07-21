#!/bin/bash

USER="${PARAM1}";
DEFAULT_HOST_USER="${USER}";
HOME_DIR="/home/${DEFAULT_HOST_USER}";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

## security modes and owner changes from root
chown -R ${USER}:${USER} ${APP_DIR};
chmod -R go-rwx ${APP_DIR};
chmod -R a-w ${APP_DIR};

## create vhost + php-fpm settings for first hold
../../helpers/apache_useradd.sh ${DEFAULT_HOST_USER} localhost 000;

## logs
../../helpers/bin/ln.sh ${HOME_DIR}/logs /var/log/${APP_NAME};
chown ${USER}:${USER} /var/log/${APP_NAME};

## I like getting there faster..
../../helpers/bin/ln.sh ${HOME_DIR}/public_html /var/www;
