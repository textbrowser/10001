#!/usr/bin/env bash

# Alexis Megas, 2019.

# Update the packages on a set of Debian machines.

# Please configure sudo on the host machines as follows:
# user ALL=(root) NOPASSWD:
# /usr/bin/aptitude update, /usr/bin/aptitude upgrade -y
# The software package aptitude is required!

# List of machines along with appropriate accounts.

command1="sudo aptitude update 2>/dev/null"
command2="sudo aptitude upgrade -y 2>/dev/null"
declare -a hosts=("192.168.178.10"
		  "192.168.178.15")

for i in "${hosts[@]}"
do
    /usr/bin/ssh $i "$command1 && $command2" 2>/dev/null
done

exit 0
