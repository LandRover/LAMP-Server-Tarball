#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

PHP_FPM="php-fpm";

## restart service
/etc/init.d/${PHP_FPM} restart