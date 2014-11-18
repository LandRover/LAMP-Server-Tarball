LAMP-Server-Tarball
===================

Unpack all:
  find . -type f \( -iname '*.tgz' -o -iname '*.tar.gz' \) -exec tar -zxf {} \;
  for i in `ls -d */`; do ln -s $i `echo $i | cut -d '-' -f1`; done
