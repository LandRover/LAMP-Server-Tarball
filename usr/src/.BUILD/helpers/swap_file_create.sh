#!/bin/bash

SWAP_FILE="/large_swap_file";

# create swap file
fallocate -l 1512M ${SWAP_FILE};
chmod 600 ${SWAP_FILE}
mkswap ${SWAP_FILE}

sudo ./bin/append_once.sh "/etc/fstab" "${SWAP_FILE} swap swap defaults 0 0" "SWAP Drive added.";

swapon -s;

swapon --show;
