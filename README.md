# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## Snippets
  - Unpack all
    - find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  - Create links
    - for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done

## @todo
  - mysql post_build
    - change owner of /opt/local/sbin/mysql (and ln)
    - create symlink for init.d/mysql
    - change owner of /home/mysql
    - verify something exists in /home/mysql || execute scripts/mysql_install_db --user=mysql
    - finalize my.cnf default config @ /opt/local/etc/mysql
  - Prevent sourced bash files to be executed directly.
  - Create apache default configs.
  - Attached profile.d and ld to post_build to relevant builds.
  - Script to Unpack and map phpMyAdmin to htdocs.
  - Install apc web-view to htdocs.
  - Create sample user and with PHP-FPM for a phpinfo page.
  - Create mailgun default email relay
  - Think of logging solution, file or other logger
  - Setup logrotate with default settings
  - Script configuring automysqlbackup
  - Script configuring Google Drive up-on change
  - Install rc.d - start on reboot
  - Reinstall VM and test all scripts.
