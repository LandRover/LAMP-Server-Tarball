# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## @todo
  - dependencies mechanism required to verify which module required prior to current
  - Template support
    - mysql: deploy ~/.my.cnf with random generated password
    - php-fpm: socket template on new user create
    - httpd: create new vhost according to template
  - Install apc web-view to htdocs part of apcu build script.
  - Script configuring automysqlbackup & cron
  - Script configuring Google Drive up-on change
  - make scripts for mariaDB
  - restart service after build
    - exim
    - httpd
    - mysql
    - php-fpm
  - exim
    - custom route for each php-fpm user
  - Reinstall VM and test all scripts. 
