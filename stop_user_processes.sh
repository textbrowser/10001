#!/bin/sh
# Alexis Megas, 2005.
# Alexis Megas, 02/24/2007. Removed clear call.
# Alexis Megas, 07/04/2007. Direct errors to /dev/null.
# A script that allows the superuser to CONTINUE or STOP another
# user's processes. The script executes in interactive or
# non-interactive modes.

# stop_user_processes.sh [-f] -c -u userid (CONTINUE)
# stop_user_processes.sh [-f] -s -u userid (STOP)

force=0
usage="usage: stop_user_processes.sh -c|-s -u USERID [-f(orce)]"

while getopts cfsu: options 2> /dev/null
do
    case $options in
	c) sig="-CONT"
	    ;;
	f) force=1
	    ;;
	s) sig="-STOP"
	    ;;
	u) userid=$OPTARG
	    ;;
	\?) echo "$usage"
	    exit 1
	    ;;
    esac
done

if [ -z "$userid" -o $OPTIND -ge 6 ]
then
    echo "$usage"
    exit 1
fi

answer=""

for pid in `ps -U $userid -o pid 2> /dev/null | tail +2 2> /dev/null`
do
    name="`ps -U $userid -o pid,comm 2> /dev/null | grep \" $pid \" 2> /dev/null | awk '{print $2}' 2> /dev/null`"

    if [ -z "$name" ]
    then
	continue
    fi

    if [ $force -eq 0 -a "$answer" != "a" ]
    then
	if [ "$sig" = "-STOP" ]
	then
	    echo "Stop $pid ($name)? [a/n/q/y]: \c"
	else
	    echo "Continue $pid ($name)? [a/n/q/y]: \c"
	fi

	read answer

	while [ "$answer" != "a" -a "$answer" != "n" -a "$answer" != "q" \
	    -a "$answer" != "y" ]
	do
	    if [ "$sig" = "-STOP" ]
	    then
		echo "Stop $pid ($name)? [a/n/q/y]: \c"
	    else
		echo "Continue $pid ($name)? [a/n/q/y]: \c"
	    fi

	    read answer
	done

	if [ "$answer" = "n" ]
	then
	    continue
	elif [ "$answer" = "q" ]
	then
	    exit 0
	fi
    fi

    kill $sig $pid 2> /dev/null

    if [ $? -eq 0 ]
    then
	if [ "$sig" = "-STOP" ]
	then
	    echo "$pid ($name) stopped."
	else
	    echo "$pid ($name) continued."
	fi
    else
	if [ "$sig" = "-STOP" ]
	then
	    echo "Error stopping $pid ($name)."
	else
	    echo "Error continuing $pid ($name)."
	fi
    fi
done

exit 0
