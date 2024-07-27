#!/bin/bash

openssl s_client -starttls imap -showcerts -connect localhost:143
openssl s_client -starttls smtp -showcerts -connect localhost:465
