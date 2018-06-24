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
  - add autossl
  - add vsftpd with default configs - from src
  - exim
    - custom route for each php-fpm user
  - Reinstall VM and test all scripts. 

## @issues
  - freetype v2.8.0 compiles but something is wrong with it
  - libgd - add support for WEBP + TIFF
  - libgd not compiling well due to freetype 2.8.0
  - php.ini - harden disable_functions
