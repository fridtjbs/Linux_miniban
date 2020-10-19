#!/bin/bash

#Setting variables
IPADDR="$1"

#BUgfix
if [[ -z "$IPADDR" ]]; then
	echo "usage: $0 <ip adresse>" 1>&2
	exit
fi

echo "Banning $IPADDR"
sudo iptables -A INPUT -s "$IPADDR" -j DROP
echo $IPADDR,$(date +%s) >> miniban.db


