#!/bin/bash

SMTP_SERVER="localhost";
SMTP_PORT=587;
FROM_EMAIL="info@sample.com";
TO_EMAIL="info@sample.com";
SUBJECT="Test Email";
BODY="This is a test email sent from the command line.";

# Prepare the email content
email_content=$(cat <<EOF
EHLO TEST-CLIENT-ID
STARTTLS
EHLO TEST-CLIENT-ID
MAIL FROM:<$FROM_EMAIL>
RCPT TO:<$TO_EMAIL>
DATA
Subject: $SUBJECT
From: $FROM_EMAIL
To: $TO_EMAIL

$BODY
.
QUIT
EOF
)

# Send the email using openssl
( 
  echo "EHLO example.com";
  echo "STARTTLS";
  sleep 1;
  echo "$email_content";
) | openssl s_client -starttls smtp -crlf -connect $SMTP_SERVER:$SMTP_PORT
