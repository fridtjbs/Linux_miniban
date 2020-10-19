#!/bin/bash

# Setter variables
IPADDR="$1"

# Sjekker om en IP-adresse følger med unban.sh
if [[ -z "$IPADDR" ]]; then
	echo "usage: $0 <ip adresse>" 1>&2
	exit
fi

# Unbanner IP-adressen
echo "Unbanning $IPADDR"
sudo iptables -D INPUT -s "$IPADDR" -j DROP

# Fjerner IP-adressen fra miniban.db
sed -i "/$IPADDR/d" miniban.db

