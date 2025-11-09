#!/usr/bin/env sh

# Alexis Megas, 2005.
# Alexis Megas, 02/24/2007. Removed the clear call.
# Alexis Megas, 07/04/2007. Direct errors to /dev/null.
# Alexis Megas, 02/23/2014. Exit with the results of the find command.
# Alexis Megas, 11/02/2025. Remove an empty temporary file.
# Alexis Megas, 11/08/2025. Enclose the file name in quotes when printing.

# Find all core files and write the results to a file in /tmp.

tempfile="$(mktemp /tmp/corefiles.$$.XXXXXX 2>/dev/null)"

if [ ! -e "$tempfile" ]
then
    echo "Unable to create \"$tempfile\"."
    exit 1
fi

echo "Searching... Writing results to \"$tempfile\"."
find / -type f -exec file {} \; 2>/dev/null | \
    grep -i 'core file' 2>/dev/null | \
    awk '{print $1}' 2>/dev/null | \
    sed s/://g > "$tempfile" 2>/dev/null

rc=$?

if [ ! -s "$tempfile" ]
then
    echo "The temporary file \"$tempfile\" is empty. Removing."
    rm -f "$tempfile"
fi

exit $rc
