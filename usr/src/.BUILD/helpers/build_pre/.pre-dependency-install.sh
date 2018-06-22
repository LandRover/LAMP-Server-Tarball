#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# Unpacks source packages at /usr/src
# file is loaded via SOURCE and must NOT BE executed directly.

function deps_error {
    echo $1;
    echo "";

    exit 0;
}
