#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
ETC_DIR="/opt/local/etc";

CERT_DIR="${ETC_DIR}/openssl/certs";
CERT_NAME="mongodb";
PEM_CERT="${CERT_DIR}/${CERT_NAME}.pem";

## profile.d
../helpers/post_etc_ln.sh "${ETC_DIR}" "profile.d" "${APP_NAME}.sh";

## Veryify cert does NOT exist.. if not found will generate one
if [[ ! -e "${PEM_CERT}" ]]; then
	##generate crt and key
	openssl req -new -x509 -days 3650 -nodes -out ${CERT_DIR}/${CERT_NAME}-cert.crt -keyout ${CERT_DIR}/${CERT_NAME}-cert.key;
	
	## combine key and cert into a single file
	cat ${CERT_DIR}/${CERT_NAME}-cert.key ${CERT_DIR}/${CERT_NAME}-cert.crt > ${PEM_CERT};
fi

#./postinit configure