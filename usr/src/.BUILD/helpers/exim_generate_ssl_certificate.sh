#!/bin/bash

## DKIM Generation
# /opt/local/sbin/openssl/bin/openssl genrsa -out /opt/local/etc/exim/virtual/domains/<DOMAIN_NAME>/ssl/dkim/dkim.key 2048
# /opt/local/sbin/openssl/bin/openssl rsa -in /opt/local/etc/exim/virtual/domains/<DOMAIN_NAME>/ssl/dkim/dkim.key -out /opt/local/etc/exim/virtual/domains/<DOMAIN_NAME>/ssl/dkim/dkim.pub -pubout
# chown mail:mail /opt/local/etc/exim/virtual/domains/<DOMAIN_NAME>/ssl/dkim/dkim.*
# chmod 600 /opt/local/etc/exim/virtual/domains/<DOMAIN_NAME>/ssl/dkim/dkim.*
#
# Add new DNS record to the domain TXT type:
# dkim_signature_id._domainkey.<DOMAIN_NAME> v=DKIM1; p=<FILE CONTANT OF /opt/local/etc/exim/virtual/domains/<DOMAIN_NAME>/ssl/dkim/dkim.pub>
#


ETC_DIR="/opt/local/etc";

mkdir -p ${ETC_DIR}/exim/ssl

echo "[INFO] Generating new P-384 ECDSA key for exim";
/opt/local/sbin/openssl/bin/openssl ecparam -name secp384r1 -genkey -out ${ETC_DIR}/exim/ssl/exim.key
/opt/local/sbin/openssl/bin/openssl req -new -x509 -days 9000 -key ${ETC_DIR}/exim/ssl/exim.key -sha384 -out ${ETC_DIR}/exim/ssl/exim.cert

echo "[INFO] Generating dhparam exim certificate";
/opt/local/sbin/openssl/bin/openssl dhparam -out ${ETC_DIR}/exim/ssl/exim_dhparam.pem 4096;

chown mail:mail ${ETC_DIR}/exim/ssl/exim*
chmod 644 ${ETC_DIR}/exim/ssl/exm*

/etc/init.d/exim restart
