# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## Snippets
  - Unpack all
    - find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  - Create links
    - for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done

## @todo
  - Install apc web-view to htdocs part of apcu build script.
  - Create sample user and with PHP-FPM for a phpinfo page.
  - Compile latest exim with mailgun relay
  - Script configuring automysqlbackup
  - Script configuring Google Drive up-on change
  - Reinstall VM and test all scripts.
  - make scripts for mariaDB
  - setup automysql backup
