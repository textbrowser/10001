#!/bin/sh
# Alexis Megas 2006, 2007.
# Upgrade the FreeBSD ports tree.

myid=`id -u`

if [ ! $myid -eq 0 ]
then
    echo "You must run cvsup-ports.sh as root. Aborting."
    exit 1
fi

supfile="/usr/local/etc/ports-supfile"

if [ -e "$supfile" ]
then
    /usr/local/bin/cvsup -g -L 0 $supfile 1> /dev/null 2> /dev/null
else
    echo "The required file $supfile does not exist. Aborting."
    exit 1
fi

if [ ! $? -eq 0 ]
then
    echo "cvsup failure. Aborting."
    exit 1
fi

# Update the index files.

cd /usr/ports 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to change directory to /usr/ports. Aborting."
    exit 1
fi

/usr/local/sbin/portsdb -Fu 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "portsdb failure. Aborting."
    exit 1
fi

# Update the portaudit database, if portaudit exists.

if [ -e /usr/local/sbin/portaudit ]
then
    /usr/local/sbin/portaudit -F 1> /dev/null 2> /dev/null
fi

# Download all of the needed distribution files.

/usr/local/sbin/portupgrade -arF 1> /dev/null 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "cvsup-ports.sh did not complete successfully."
    exit 1
fi

exit 0
