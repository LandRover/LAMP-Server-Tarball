# LAMP-Server-Tarball
===================

Optimized build scripts for custom install a Debian wheezy server LAMP based.

## Snippets:
  - Unpack all: find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  - Create links: for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done
