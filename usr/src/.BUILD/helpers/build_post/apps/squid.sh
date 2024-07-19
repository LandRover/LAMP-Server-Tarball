#!/bin/bash

USER="${PARAM1}";
CERT_PATH="${ETC_DIR}/${APP_NAME}/certs";
LOG_PATH="/var/log/${APP_NAME}";

[ -z "${USER}" ] && usage "[error] User was not set. Halt. As squid setup requires a user.";

## create and own logs
[ ! -d "${LOG_PATH}" ] && mkdir ${LOG_PATH} && chown ${USER}:${USER} ${LOG_PATH};

## create and own certs
[ ! -d "${CERT_PATH}" ] && mkdir -p ${CERT_PATH} && chown ${USER}:${USER} ${CERT_PATH}

${BIN_DIR}/openssl/bin/openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -extensions v3_ca -keyout ${CERT_PATH}/squid-ca-key.pem -out ${CERT_PATH}/squid-ca-cert.pem

cat ${CERT_PATH}/squid-ca-cert.pem ${CERT_PATH}/squid-ca-key.pem >> ${CERT_PATH}/squid-ca-cert-key.pem
chown ${USER}:${USER} -R ${CERT_PATH}
