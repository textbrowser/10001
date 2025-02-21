#!/usr/bin/env bash

# Alexis Megas, 2019.

for file in "$@"
do
    declare -i found
    declare -i line
    declare -i previous

    found=0
    previous=-1

    for line in $(grep -e '^$' -n $file | sed 's|:||g')
    do
	line=$line-1

	if [ $line -eq $previous ]
	then
	    if [ $found -eq 0 ]
	    then
		echo $file

		found=1
	    fi

	    echo "line " $line
	fi

	previous=$line+1
    done
done

exit 0
