#!/bin/bash

USER="${PARAM1}";
[ -z "${USER}" ] && usage "[error] User was not set. Halt. As squid setup requires a user.";

## create and own logs
[ ! -d "/var/log/${APP_NAME}" ] && mkdir /var/log/${APP_NAME} && chown ${USER}:${USER} /var/log/${APP_NAME};

## create and own certs
[ ! -d "/etc/${APP_NAME}/certs" ] && mkdir /etc/${APP_NAME}/certs && chown ${USER}:${USER} /etc/${APP_NAME}/certs

openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -extensions v3_ca -keyout /etc/${APP_NAME}/certs/squid-ca-key.pem -out /etc/${APP_NAME}/certs/squid-ca-cert.pem
cat /etc/${APP_NAME}/certs/squid-ca-cert.pem /etc/${APP_NAME}/certs/squid-ca-key.pem >> /etc/${APP_NAME}/certs/squid-ca-cert-key.pem
chown ${USER}:${USER} -R /etc/${APP_NAME}/certs

# auto start
update-rc.d ${APP_NAME} defaults
