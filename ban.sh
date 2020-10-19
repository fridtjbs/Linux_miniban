#!/bin/bash

# Setter variables
IPADDR="$1"

# Sjekker at en IP-adresse følger med 
if [[ -z "$IPADDR" ]]; then
	echo "usage: $0 <ip adresse>" 1>&2
	exit
fi

# Banner en IP-adressen 
echo "Banning $IPADDR"
sudo iptables -A INPUT -s "$IPADDR" -j DROP

# Sender IP-adressen til miniban.db
echo $IPADDR,$(date +%s) >> miniban.db


