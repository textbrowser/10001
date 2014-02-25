#!/bin/sh
# Alexis Megas, 2005.
# Alexis Megas, 02/24/2007. Removed the clear call.
#                           Use stat instead of ls if it's available.
# Alexis Megas, 07/04/2007. Direct errors to /dev/null.
# Alexis Megas, 02/23/2014. Verify that the directory is readable.
# List all broken links. Delete them if the -r option is provided.

usage="usage: find_broken_links.sh -d DIR [-r(emove)]"
delete=0
directory=""

while getopts d:r options 2> /dev/null
do
    case $options in
	d) directory="$OPTARG"
	    ;;
	r) delete=1
	    ;;
    esac
done

if [ -z "$directory" ]
then
    echo "$usage"
    exit 1
elif [ ! -d "$directory" -o ! -r "$directory" -o ! -w "$directory" -o \
    ! -x "$directory" ]
then
    echo "Unable to access the directory $directory."
    exit 1
fi

stat -L / 1> /dev/null 2> /dev/null

if [ $? -eq 0 ]
then
    command="stat -L"
else
    command="ls -L"
fi

find $directory -type l 2> /dev/null | while read line
do
    $command $line 1> /dev/null 2> /dev/null
    rc=$?

    if [ ! $rc -eq 0 -a $delete -eq 1 ]
    then
	rm $line 2> /dev/null

	if [ $? -eq 0 ]
	then
	    echo "Removed symbolic link $line."
	else
	    echo "Could not remove symbolic link $line."
	fi
    elif [ ! $rc -eq 0 ]
    then
	echo "$line"
    fi
done

exit 0
