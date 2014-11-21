#!/bin/bash

## generate phpinfo file

FILE_NAME="sendmail.php";
WWW="/opt/local/sbin/httpd/htdocs";

cat > ${WWW}/${FILE_NAME} <<'endmsg'
<?php
    $emailTo = "[RCPT TO HERE]";
    $emailSubject = 'Testing EXIM';
    $emailMessage = 'This is a Test mail';

    // create email headers
    $headers = 'From: root@test.com'."\r\n".
               'Reply-To: root@test.com'."\r\n" .
               'X-Mailer: PHP/' . phpversion();

     $result = mail($emailTo, $emailSubject, $emailMessage, $headers);

     if ($result) echo 'Mail accepted for delivery ';
     if (!$result) echo 'Test unsuccessful... ';
endmsg