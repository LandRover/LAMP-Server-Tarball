#!/bin/bash

# create swap file
fallocate -l 1512M /large_swap_file
chmod 600 /large_swap_file
mkswap /large_swap_file

 # add to /etc/fstb:
 # /swapfile swap swap defaults 0 0

swapon -s

swapon --show
