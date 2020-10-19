#!/bin/bash

declare -A IPS


if [[ "$USER" != root ]]; then
	echo"You must be root" 1>&2
	exit
fi
echo "Running miniban, CTRL+C to exit"


trap "kill $(jobs -p)" EXIT

update(){
while IFS="," read IP TIMESTAMP < miniban.db; do
	if [[ -z $IP ]]; then
		break
	fi 
		TIME=$(date +%s)	
		SEC=$((TIME - TIMESTAMP))
		if [[ $SEC -ge 60 ]]; then
			./unban.sh "$IP"
		fi
sleep 1
done
}
while true; do
	update
sleep 1
done&


journalctl -f -u ssh -n 0 | grep Failed --line-buffered | grep --line-buffered -o '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | while read IP; do

	IPS["$IP"]=$(( IPS["$IP"] += 1 ))

	echo "i have seen: $IP ${IPS["$IP"]} times"

	if [[ ${IPS["$IP"]} -ge 3 ]]; then
		./ban.sh "$IP"
		IPS["$IP"]=$(( IPS["IP"] = 0 ))
	fi
done
wait

