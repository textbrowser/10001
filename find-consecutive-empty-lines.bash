#!/usr/bin/env bash

# Alexis Megas, 2019.

clear

for file in "$@"
do
    if [ -d "$file" ]
    then
	echo "Skipping the directory \"$file\"."
	continue
    fi

    declare -i found
    declare -i line
    declare -i previous

    found=0
    previous=-1

    for line in $(grep -e '^$' -n "$file" | sed 's|:||g' 2>/dev/null)
    do
	line=$line-1

	if [ $line -eq $previous ]
	then
	    if [ $found -eq 0 ]
	    then
		echo "$file"

		found=1
	    fi

	    echo "line:" $line
	fi

	previous=$line+1
    done
done
