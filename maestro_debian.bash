#!/usr/bin/env bash
# Alexis Megas, 2019.
# Update the packages on a set of Debian machines.

# Please configure sudo on the host machines as follows:
# user ALL=(root) NOPASSWD: /usr/bin/aptitude update, /usr/bin/aptitude upgrade -y

# The software package aptitude is required!

# List of machines along with appropriate accounts.

declare -a hosts=("user@192.168.178.10"
		  "user@192.168.178.12")

for i in "${hosts[@]}"
do
    /usr/bin/ssh $i "sudo aptitude update && sudo aptitude upgrade -y"
done
