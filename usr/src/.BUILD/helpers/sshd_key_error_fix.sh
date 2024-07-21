#!/bin/bash

OPENSSH_PATH="/opt/local/etc/openssh";

echo "[INFO] Removing old keys";
rm -r ${OPENSSH_PATH}/ssh*key;

echo "[INFO] Generating new keys";

ssh-keygen -t rsa -f ${OPENSSH_PATH}/ssh_host_rsa_key;
ssh-keygen -t dsa -f ${OPENSSH_PATH}/ssh_host_dsa_key;
ssh-keygen -t ecdsa -f ${OPENSSH_PATH}/ssh_host_ecdsa_key;

echo "[INFO] All keys generated.";

ls -al ${OPENSSH_PATH}/ssh*key;

echo "[INFO] Restarting SSH service";
/etc/init.d/openssh restart;
