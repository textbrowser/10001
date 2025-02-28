#!/usr/bin/env bash

# Alexis Megas.

clear

for i in $(find ${1} -iname '*.cc' -or -iname '*.h' 2>/dev/null)
do
    found=0

    for j in $(grep '[[:space:]]*#include[[:space:]]*<Q' $i | \
	       awk '{print $2}' | sed 's/["<>]//g' 2>/dev/null)
    do
	c=$(grep -c $j $i 2>/dev/null)

	if [ $c -lt 2 ]
	then
	    if [ $found -eq 0 ]
	    then
		echo "Processing file $i... "

		found=1
	    fi

	    echo "$c:$j"
	fi
    done
done
