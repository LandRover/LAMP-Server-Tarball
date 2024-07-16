#!/bin/bash

../bin/ln.sh "${ETC_DIR}/${APP_NAME}" "/etc/ssh";
../bin/ln.sh "${ETC_DIR}/init.d/openssh" "/etc/init.d/ssh";
