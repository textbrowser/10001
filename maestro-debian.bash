#!/usr/bin/env bash

# Alexis Megas, 2019.
# Alexis Megas, 2025. Safer sudo.

# Issue apt-update and apt-upgrade on a set Debian machines.

command1="sudo apt update"
command2="sudo apt upgrade -y"
command3="sudo apt autoclean -y"
command4="sudo apt autopurge -y"
command5="sudo apt autoremove -y"
commands="$command1 && $command2 && $command3 && $command4 && $command5"
declare -a hosts=("192.168.178.5"
		  "192.168.178.20"
		  "192.168.178.40"
		  "192.168.178.45"
		  "192.168.178.65")

for i in "${hosts[@]}"
do
    echo "Connecting to $i..."
    /usr/bin/ssh -t $i "$commands" 2>/dev/null
done
