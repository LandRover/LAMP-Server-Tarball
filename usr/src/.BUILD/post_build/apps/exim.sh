#!/bin/bash

ETC_DIR="/opt/local/etc";
USER="$4";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As apache setup requires a user.";

## create logs dir
[ ! -d "/var/log/${APP_NAME}" ] && mkdir "/var/log/${APP_NAME}" && chown -R ${USER}:${USER} /var/log/${APP_NAME};

## restart service
/etc/init.d/${APP_NAME} restart