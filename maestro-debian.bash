#!/usr/bin/env bash

# Alexis Megas, 2019.
# Alexis Megas, 2025. Safer sudo.

# Issue apt-update and apt-upgrade on a set Debian machines.

command1="sudo apt update"
command2="sudo apt upgrade -y"
declare -a hosts=("192.168.178.45"
		  "192.168.178.65")

for i in "${hosts[@]}"
do
    /usr/bin/ssh -t $i "$command1 && $command2" 2>/dev/null
done
