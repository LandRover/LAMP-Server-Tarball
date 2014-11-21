# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## Snippets
  - Unpack all
    - find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  - Create links
    - for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done

## @todo
  - auto unpack up-on build run (allow overwrite flag to force delete the old and re-unpack)
  - Install apc web-view to htdocs part of apcu build script.
  - Create new vhost generator bash, template based
  - Script configuring automysqlbackup
  - Script configuring Google Drive up-on change
  - Reinstall VM and test all scripts.
  - make scripts for mariaDB
  - setup automysql backup
