#!/bin/bash

../bin/ln.sh "${ETC_DIR}/${APP_NAME}" "/etc/ssh";
../bin/ln.sh "${ETC_DIR}/init.d/${APP_NAME}" "/etc/init.d/ssh";

# Cleanup original configs of ssh, causes issues to autostart if present.
rm -rf /etc/systemd/system/ssh.service.d;
rm -rf /lib/systemd/system/ssh.service;
rm -rf /etc/systemd/system/sshd-keygen@.service.d;

# cleanup pre-installed app
apt-get remove -y ${APP_NAME}-server;
apt-get autoremove;
