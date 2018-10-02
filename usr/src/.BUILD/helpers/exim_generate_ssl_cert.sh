#!/bin/bash

mkdir -p /opt/local/etc/exim/ssl

/opt/local/sbin/openssl/bin/openssl req -x509 -sha256 -days 9000 -nodes -newkey rsa:4096 -keyout /opt/local/etc/exim/ssl/exim.key -out /opt/local/etc/exim/ssl/exim.cert
#/opt/local/sbin/openssl/bin/openssl req -x509 -newkey rsa:1024 -keyout /opt/local/etc/exim/ssl/exim.key -out /opt/local/etc/exim/ssl/exim.cert -days 9999 -nodes

chown exim:exim /opt/local/etc/exim/ssl/exim.key
chmod 644 /opt/local/etc/exim/ssl/exim.key
chmod 644 /opt/local/etc/exim/ssl/exim.cert

/etc/init.d/exim restart
