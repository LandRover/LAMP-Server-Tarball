# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## @todo
  - dependencies mechanism required to verify which module required prior to current
  - Install apc web-view to htdocs part of apcu build script.
  - Script configuring automysqlbackup & cron
  - Script configuring Google Drive up-on change
  - add postgresql scripts
  - make scripts for mariaDB
  - add letsencrypt
  - add vsftpd with default configs - from src
  - add composer install script
      php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
      mkdir -p /opt/local/sbin/bin/composer
      php composer-setup.php --install-dir=/opt/local/sbin/bin/composer --filename=composer
  - exim
    - custom route for each php-fpm user
  - Reinstall VM and test all scripts.
  - add  curl --remote-name --time-cond cacert.pem https://curl.haxx.se/ca/cacert.pem to /opt/local/etc/openssl/certs during postinstall for openssl


## @issues
  - freetype v2.8.0 compiles but something is wrong with it
  - libgd - add support for WEBP + TIFF
  - libgd not compiling well due to freetype 2.8.0
  - php.ini - harden disable_functions
