#!/bin/bash

mkdir -p /opt/local/etc/exim/ssl

echo "[INFO] Generating new P-384 ECDSA key for exim";
/opt/local/sbin/openssl/bin/openssl ecparam -name secp384r1 -genkey -out /opt/local/etc/exim/ssl/exim.key
/opt/local/sbin/openssl/bin/openssl req -new -x509 -days 9000 -key /opt/local/etc/exim/ssl/exim.key -sha384 -out /opt/local/etc/exim/ssl/exim.cert

echo "[INFO] Generating dhparam exim certificate";
/opt/local/sbin/openssl/bin/openssl dhparam -out /opt/local/etc/exim/ssl/exim_dhparam.pem 4096;

chown mail:mail /opt/local/etc/exim/ssl/exim*
chmod 644 /opt/local/etc/exim/ssl/exm*

/etc/init.d/exim restart
