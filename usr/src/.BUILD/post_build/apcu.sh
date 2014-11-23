#!/bin/bash

ETC_DIR="/opt/local/etc";
ETC_PHPD="${ETC_DIR}/php/php.d";

echo "[info] Deploying apcu.ini default settings.";
cp -Lf  ../templates/php/apcu/apcu.ini ${ETC_PHPD}/;

echo "[info] Restarting PHP-FPM...";
/etc/init.d/php-fpm restart;