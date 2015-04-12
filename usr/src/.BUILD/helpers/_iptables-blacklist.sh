#!/bin/bash

echo "Stopping firewall and allowing everyone..."

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

for fn in `cat _black-list.txt`; do
  iptables -A INPUT -s $fn -p tcp --destination-port 80 -j DROP
done
