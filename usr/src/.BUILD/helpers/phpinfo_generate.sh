#!/bin/bash

## generate phpinfo file

FILE_NAME="phpinfo.php";
WWW="/opt/local/sbin/httpd/htdocs";

echo "<?php phpinfo();" > "${WWW}/${FILE_NAME}";