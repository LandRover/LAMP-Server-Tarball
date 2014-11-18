#!/bin/bash

ps -ef | grep -i httpd | awk '{print $1}';