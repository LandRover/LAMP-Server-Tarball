#!/bin/bash

## generate phpinfo file

FILE_NAME="phpinfo.php";
USER="apache";
WWW="/home/${USER}/public_html";

echo "<?php phpinfo();" > ${WWW}/${FILE_NAME};
chown ${USER}:${USER} ${WWW}/${FILE_NAME};