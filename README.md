# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## @todo
  - dependencies mechanism required to verify which module required prior to current
  - Install apc web-view to htdocs part of apcu build script.
  - Script configuring automysqlbackup & cron
  - Script configuring Google Drive up-on change
  - make scripts for mariaDB
  - add vsftpd with default configs - from src
  - exim
    - custom route for each php-fpm user
  - Reinstall VM and test all scripts. 

## @issues
  - freetype v2.8.0 compiles but something is wrong with it
  - libgd - add support for WEBP + TIFF
  - libgd not compiling well due to freetype 2.8.0
  - defaulthost public_html should be at /home/defaulthost/public_html rather than 
    - move phpmyadmin here after done.
  - php.ini - harden disable_functions
