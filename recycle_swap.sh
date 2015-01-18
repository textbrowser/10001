#/bin/sh
# Alexis Megas, 2015.
# Recycle swap.

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

freereal="`free | grep -i mem | awk '{print $4}' 2> /dev/null`"

if [ -z "$freereal" ]
then
    echo "awk and/or grep error."
    exit 1
fi

used="`free | grep -i swap | awk '{print $3}' 2> /dev/null`"

if [ -z "$used" ]
then
    echo "awk and/or grep error."
    exit 1
fi

if [ $used -eq 0 ]
then
    echo "Swap is not used."
    exit 0
fi

difference=`expr $freereal - $used`

if [ $difference -le 0 ]
then
    echo "Insufficient physical memory."
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
