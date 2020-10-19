#!/bin/bash

#Setting variables
IPADDR="$1"

#BUgfix
if [[ -z "$IPADDR" ]]; then
	echo "usage: $0 <ip adresse>" 1>&2
	exit
fi

# Unbanning IP
echo "Unbanning $IPADDR"
sudo iptables -D INPUT -s "$IPADDR" -j DROP

# Removing IP from database
sed -i "/$IPADDR/d" miniban.db

