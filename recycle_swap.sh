#!/bin/sh
# Alexis Megas, 2015.
# Recycle swap if there is sufficient physical memory.

myid=`id -u 2> /dev/null`

if [ ! $myid -eq 0 ]
then
    echo "You must execute recycle_swap.sh as root. Aborting."
    exit 1
fi

free="`which free 2> /dev/null`"

if [ ! -x "$free" ]
then
    echo "Unable to locate free."
    exit 1
fi

swapoff="`which swapoff 2> /dev/null`"

if [ ! -x "$swapoff" ]
then
    echo "Unable to locate swapoff."
    exit 1
fi

swapon="`which swapon 2> /dev/null`"

if [ ! -x "$swapon" ]
then
    echo "Unable to locate swapon."
    exit 1
fi

P=25

while getopts p: options 2> /dev/null
do
    case $options in
	p) P=$OPTARG
	    ;;

    esac
done

if [ -z "$P" ]
then
    echo "Incorrect percent value."
    exit 1
fi

if [ $P -lt 1 -o $P -gt 100 ]
then
    echo "The percent must be in the range [1, 100]."
    exit 1
fi

freereal="`free | grep -i mem | awk '{print $4}' 2> /dev/null`"

if [ -z "$freereal" ]
then
    echo "awk and/or grep error(s)."
    exit 1
fi

usedswap="`free | grep -i swap | awk '{print $3}' 2> /dev/null`"

if [ -z "$usedswap" ]
then
    echo "awk and/or grep error(s)."
    exit 1
fi

if [ $usedswap -eq 0 ]
then
    echo "Swap space is not consumed."
    exit 0
fi

difference=`expr $freereal - $usedswap`

if [ $difference -le 0 ]
then
    echo "Insufficient physical memory."
    exit 1
fi

totalreal="`free | grep -i mem | awk '{print $2}' 2> /dev/null`"

if [ -z "$totalreal" ]
then
    echo "awk and/or grep error(s)."
    exit 1
fi

if [ $totalreal -le 0 ]
then
    echo "Unable to determine the total amount of physical memory."
    exit 1
fi

percent=`expr 100 \* \( $freereal - $usedswap \) / $totalreal`

if [ $P -lt $percent ]
then
    echo "Insufficient physical memory: computed percentage is $percent, " \
	"while P is $P."
    exit 1
fi

swapoff="$swapoff -a"
$swapoff

if [ ! $? -eq 0 ]
then
    echo "swapoff failure."
    exit 1
fi

swapon="$swapon -a"
$swapon

if [ ! $? -eq 0 ]
then
    echo "swapon failure."
    exit 1
fi

exit 0
