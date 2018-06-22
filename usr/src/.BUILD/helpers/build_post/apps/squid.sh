#!/bin/bash

USER="${PARAM1}";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As squid setup requires a user.";

## create and own logs
[ ! -d "/var/log/${APP_NAME}" ] && mkdir /var/log/${APP_NAME} && chown ${USER}:${USER} /var/log/${APP_NAME};
