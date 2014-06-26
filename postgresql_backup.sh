#!/bin/sh
# Alexis Megas 2014.

pgdumpallfile="`which pg_dumpall 2> /dev/null`"

if [ ! -r "$pgdumpallfile" -o ! -x "$pgdumpallfile" ]
then
    echo "Unable to locate pg_dumpall. Exiting."
    exit 1
fi

$pgdumpallfile "$@" --clean --file=pg_dumpall.$$ --host=localhost \
    --password 2>/dev/null

if [ ! $? -eq 0 ]
then
    echo "pg_dumpall failed."
    exit 1
fi

exit 0
