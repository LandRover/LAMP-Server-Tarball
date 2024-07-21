#!/bin/bash

USER="${PARAM1}";

USER_PATH="/home/${USER}";
RUN_PATH="/var/run/influxdb2";
LOG_PATH="/var/log/influxdb2";

## security modes and owner changes from root
echo "[INFO] Changing permirrion to ${USER_PATH}";
chown -R ${USER}:${USER} ${USER_PATH};

echo "[INFO] Changing permirrion to ${RUN_PATH}";
chown -R ${USER}:${USER} ${RUN_PATH};

echo "[INFO] Changing permirrion to ${LOG_PATH}";
chown -R ${USER}:${USER} ${LOG_PATH};
