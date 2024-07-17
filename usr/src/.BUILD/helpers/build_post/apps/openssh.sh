#!/bin/bash

../bin/ln.sh "${ETC_DIR}/${APP_NAME}" "/etc/ssh";
../bin/ln.sh "${ETC_DIR}/init.d/${APP_NAME}" "/etc/init.d/ssh";

# cleanup pre-installed app
apt-get remove -y ${APP_NAME}-server;
apt-get autoremove;
