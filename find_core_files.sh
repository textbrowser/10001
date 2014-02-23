#!/bin/sh
# Alexis Megas, 2005.
# Alexis Megas, 02/24/2007. Removed the clear call.
# Alexis Megas, 07/04/2007. Direct errors to /dev/null.
# Alexis Megas, 02/23/2014. Exit with the results of the find command.
# Find all core files and write the results to a file in /tmp.

tempfile="`mktemp /tmp/corefiles.$$.XXXXXX 2> /dev/null`"
trap 'echo "Killed."; echo "Removing $tempfile."; rm $tempfile 2> /dev/null; exit 1' INT

if [ ! -e "$tempfile" ]
then
    echo "Unable to create $tempfile."
    exit 1
fi

echo "Searching... Writing results to $tempfile."
find / -type f -exec file {} \; 2> /dev/null | \
    grep -i 'core file' 2> /dev/null | awk '{print $1}' 2> /dev/null | sed s/://g > $tempfile 2> /dev/null
exit $?
