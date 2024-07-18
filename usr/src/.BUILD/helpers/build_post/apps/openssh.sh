#!/bin/bash

../bin/ln.sh "${ETC_DIR}/${APP_NAME}" "/etc/ssh";

# Cleanup original configs of ssh, causes issues to autostart if present.
rm -rf /lib/systemd/system/ssh*;
rm -rf /etc/systemd/system/ssh*;

# cleanup pre-installed app
apt-get remove -y ${APP_NAME}-server;
apt-get autoremove;
