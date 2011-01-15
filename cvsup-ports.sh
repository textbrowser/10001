#!/bin/sh
# Alexis Megas 2006, 2007.
# Alexis Megas 09/12/2008. Removed absolute paths.
# Upgrade the FreeBSD ports tree.

myid=`id -u 2> /dev/null`

if [ ! $myid -eq 0 ]
then
    echo "You must run cvsup-ports.sh as root. Aborting."
    exit 1
fi

supfile="/usr/local/etc/ports-supfile"

if [ -e "$supfile" ]
then
    echo -n "Running cvsup... "
    cvsup -g -L 0 $supfile 1> /dev/null 2> /dev/null
else
    echo "The required file $supfile does not exist. Aborting."
    exit 1
fi

if [ ! $? -eq 0 ]
then
    echo "cvsup failure. Aborting."
    exit 1
else
    echo "OK."
fi

# Update the index files.

cd /usr/ports 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to change directory to /usr/ports. Aborting."
    exit 1
fi

echo -n "Updating the index files... "
portsdb -Fu 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "portsdb failure. Aborting."
    exit 1
else
    echo "OK."
fi

# Update the portaudit database, if portaudit exists.

if [ -x "`which portaudit 2> /dev/null`" ]
then
    echo -n "Updating the portaudit database... "
    portaudit -F 1> /dev/null 2> /dev/null

    if [ ! $? -eq 0 ]
    then
	echo "portaudit failure."
    else
	echo "OK."
    fi
fi

# Download all of the needed distribution files.

echo -n "Downloading distribution files... "
portupgrade -arF 1> /dev/null 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "cvsup-ports.sh did not complete successfully."
    exit 1
else
    echo "OK."
fi

exit 0
