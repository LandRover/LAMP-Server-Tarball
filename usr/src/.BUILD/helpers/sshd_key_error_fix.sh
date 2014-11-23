#!/bin/bash

echo "[info] Removing old keys";
rm -r /etc/ssh/ssh*key;

echo "[info] Generating new keys";

ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key;
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key;
ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key;

echo "[info] All keys generated.";

ls -al /etc/ssh/ssh*key;

echo "[info] Restarting SSH service";
/etc/init.d/ssh restart;