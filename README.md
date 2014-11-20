# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## Snippets
  - Unpack all
    - find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  - Create links
    - for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done

## @todo
  - Create apache default configs and vhosts
  - Install apc web-view to htdocs.
  - Create sample user and with PHP-FPM for a phpinfo page.
  - Create mailgun default email relay
  - Think of logging solution, file or other logger
  - Setup logrotate with default settings
  - Script configuring automysqlbackup
  - Script configuring Google Drive up-on change
  - Install rc.d - start on reboot
  - Reinstall VM and test all scripts.
  - make scripts for mariaDB
  - add logs ref at /usr/log/httpd to point the actual logs of apache
