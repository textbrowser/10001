#!/bin/sh
# Alexis Megas, 2005. Initial implementation.
# Alexis Megas, 2006. Also search for the .mozilla directory.
# Alexis Megas, 02/24/2007. Removed the clear call.
# Alexis Megas, 06/27/2007. Added the urlclassifier2.sqlite file.
# Alexis Megas, 07/04/2007. Direct errors to /dev/null.
# Alexis Megas, 07/16/2007. Updated for OS X 10.4.10.
# Alexis Megas, 07/20/2007. Resolved an accidental issue.
# Alexis Megas, 08/21/2007. Added additional files to delete.
#                           Directing more errors to /dev/null.
# Alexis Megas, 02/20/2008. Changed SCRIPTS101_DIR to SHUTS_DIR.
# Alexis Megas, 09/07/2008. Changed urlclassifier2.sqlite to
#                           urlclassifier*.sqlite.
# Alexis Megas, 09/24/2008. Added more files.
# Alexis Megas, 10/08/2008. The wipe command is now supported.
# Alexis Megas, 10/24/2008. Changed sessionstore.js to sessionstore.*.
# Alexis Megas, 04/21/2009. Added search.json and secmod.db.
# Alexis Megas, 11/04/2010. Fixed empty answer.
# Alexis Megas, 04/27/2012. Added -q to wipe.
# Alexis Megas, 02/23/2014. Verify that files are readable.
# An interactive script that allows the user to remove Firefox
# files (cookies.txt, etc.).

# Non-interactive?

interactive=0
firefox=""
command=""
command_flags=""
usage="usage: \
secure_firefox_cleanup.sh -d FIREFOX_DIR -p PROGRAM (bcwipe|rm|srm|wipe)"
list="Cache.Trash formhistory.dat downloads.* Cache cookies.* history.dat places.* secmod.db search.json sessionstore.* urlclassifier*.* blocklist.xml bookmarkbackups *.sqlite"

while getopts d:p: options 2> /dev/null
do
    interactive=1

    case $options in
    d) firefox="$OPTARG"
       ;;
    p) command="$OPTARG"
       ;;
    esac
done

if [ $interactive -ne 0 ]
then
    if [ -z "$command" -o -z "$firefox" ]
    then
	echo "$usage"
	exit 1
    fi

    case "$command" in
    bcwipe) command_flags="-Ifrv"
	    ;;
    rm)     command_flags="-frv"
	    ;;
    srm)    command_flags="-frv"
	    ;;
    wipe)   command_flags="-fir -q -Q 16"
            ;;
    esac

    if [ -z "$command_flags" ]
    then
	echo "$usage"
	exit 1
    fi

    for file in $list
    do
	find "$firefox" -name $file -exec $command $command_flags {} \; \
	    2> /dev/null
    done

    exit 0
fi

if [ -z "$SHUTS_DIR" ]
then
    if [ -r ./functions.sh ]
    then
	. ./functions.sh
    elif [ -r /usr/local/bin/functions.sh ]
    then
	. /usr/local/bin/functions.sh
    else
	echo "functions.sh was not found."
	exit 1
    fi
else
    if [ -r $SHUTS_DIR/functions.sh ]
    then
	. $SHUTS_DIR/functions.sh
    else
	echo "$SHUTS_DIR/functions.sh was not found."
	exit 1
    fi
fi

background_check

# Determine the user's home directory.

userid="`who -m 2> /dev/null | awk '{print $1}' 2> /dev/null`"

if [ -d /home/$userid ]
then
    homedir="/home/$userid"
elif [ -d /Users/$userid ]
then
    homedir="/Users/$userid"
else
    homedir=""
fi

if [ -z "$homedir" ]
then
    echo "Unable to determine your home directory."

    while [ ! -d "$homedir" -o ! -r "$homedir" -o ! -x "$homedir" ]
    do
	echo "Please enter your home directory: \c"
	read homedir

	if [ ! -d "$homedir" -o ! -r "$homedir" -o ! -x "$homedir" ]
	then
	    echo "The directory $homedir cannot be accessed."
	fi
    done
fi

# Find the Firefox directory.

echo "Searching for Firefox directories..."

for name in `find $homedir \( -name "*[F|f][I|i][R|r][E|e][F|f][O|o][X|x]*" -o -name "\.[M|m][O|o][Z|z][I|i][L|l][L|l][A|a]" \) -type d 2> /dev/null`
do
    echo "$name"
    echo "(n)ext, (q)uit, (s)elect: \c"
    read answer

    while [ "$answer" != "n" -a "$answer" != "s" -a "$answer" != "q" -a \
            "$answer" != "s" ]
    do
        echo "(n)ext, (q)uit, or (s)elect: \c"
        read answer
    done

    if [ "$answer" = "S" -o "$answer" = "s" ]
    then
        firefox=$name
        break
    elif [ "$answer" = "q" ]
    then
        exit 1
    else
        firefox=""
    fi
done

if [ -z "$firefox" ]
then
    echo "A Firefox directory was not found or was not selected."
    exit 1
else
    echo "You selected $firefox."
fi

# Determine the removal method.

cmdfile="`which $command 2> /dev/null`"
command=""

while [ ! -r "$cmdfile" -o ! -x "$cmdfile" ]
do
    answer=0

    while [ $answer -ge 5 -o $answer -le 0 ]
    do
        echo "Which removal method would you like to use?"
	echo "1 - bcwipe"
	echo "2 - rm"
	echo "3 - srm"
	echo "4 - wipe"
	echo "Answer: \c"
	read answer

	if [ ! "$answer" ]
	then
	    answer=0
	fi
    done

    case "$answer" in
	1) command="bcwipe"
	command_flags="-Irv"
	;;
	2) command="rm"
	command_flags="-frv"
	;;
	3) command="srm"
	command_flags="-frv"
	;;
	4) command="wipe"
	command_flags="-fir -q -Q 16"
	;;
	*) command="wipe"
	command_flags="-fir -Q 16"
	;;
    esac

    cmdfile="`which $command 2> /dev/null`"

    if [ ! -r "$cmdfile" -o ! -x "$cmdfile" ]
    then
	echo "Command $command not found."
    fi
done

for file in $list
do
    find "$firefox" -name $file -exec $command $command_flags {} \; 2> \
	/dev/null
done

exit 0
