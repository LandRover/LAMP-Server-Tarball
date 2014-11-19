# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## Snippets
  - Unpack all
    - find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  - Create links
    - for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done

## @todo
  - Prevent sourced bash files to be executed directly.
  - Compile php with latest PCRE from source as well.
  - Create apache default configs.
  - Attached profile.d and ld to post_build to relevant builds.
  - Unpack and map phpMyAdmin to htdocs.
  - Install apc web-view to htdocs.
  - Reinstall VM and test all scripts.
  - Create sample user and with PHP-FPM for a phpinfo page.
