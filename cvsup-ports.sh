#!/bin/sh
# Alexis Megas 2006, 2007.
# Alexis Megas 09/12/2008. Removed absolute paths.
# Alexis Megas 02/23/2014. Verify that /usr/local/etc/ports-supfile
#                          has read permissions.
# Upgrade the FreeBSD ports tree.

myid=`id -u 2> /dev/null`

if [ ! $myid -eq 0 ]
then
    echo "You must execute cvsup-ports.sh as root. Aborting."
    exit 1
fi

supfile="/usr/local/etc/ports-supfile"

if [ -r "$supfile" ]
then
    echo -n "Executing cvsup... "
    cvsup -L 0 -g $supfile 1> /dev/null 2> /dev/null
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
portsdb -Fu 1> /dev/null 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "portsdb failure. Aborting."
    exit 1
else
    echo "OK."
fi

# Update the portaudit database, if portaudit exists.

portauditfile="`which portaudit 2> /dev/null`"

if [ -r "$portauditfile" -a -x "$portauditfile" ]
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
portupgrade -Far 1> /dev/null 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "cvsup-ports.sh did not complete successfully."
    exit 1
else
    echo "OK."
fi

exit 0
