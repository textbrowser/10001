#!/usr/bin/env bash

# Alexis Megas.

# Discover accounts and their respective home directories.

for u in $(getent passwd | sort | awk 'BEGIN {FS=":"} ; {print $1}' 2>/dev/null)
do
    e="$(getent passwd \"$u\" | rev | cut -d':' -f1 | rev 2>/dev/null)"
    h="$(getent passwd \"$u\" | cut -d':' -f6 2>/dev/null)"

    if [ "$e" = "/bin/false" ] ||
       [ "$e" = "/sbin/nologin" ] ||
       [ "$e" = "/usr/sbin/nologin" ] ||
       [ -z "$e" ]
    then
	echo "$u:/nonexistent"
    else
	echo "$u:$h"
    fi
done

exit 0

# Using a temporary file.

tmp="/tmp/accounts.$(date +'%Y%m%d%H%S').txt"

getent passwd | sort | awk 'BEGIN {FS=":"} ; {print $1}' > "$tmp"

while read -r u
do
    e="$(getent passwd \"$u\" | rev | cut -d':' -f1 | rev 2>/dev/null)"
    h="$(getent passwd \"$u\" | cut -d':' -f6 2>/dev/null)"

    if [ "$e" = "/bin/false" ] ||
       [ "$e" = "/sbin/nologin" ] ||
       [ "$e" = "/usr/sbin/nologin" ] ||
       [ -z "$e" ]
    then
	echo "$u:/nonexistent"
    else
	echo "$u:$h"
    fi
done < "$tmp"

rm -f "$tmp"
