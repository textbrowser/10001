#!/bin/sh
# Alexis Megas, 2005.
# Alexis Megas, 02/24/2007. Removed the clear call.
# Alexis Megas, 07/04/2007. Direct errors to /dev/null.
# Alexis Megas, 02/23/2014. The provided file must be readable.
# Split a file into at least n parts.

N=1
file=""
usage="usage: nsplit.sh -f FILE -n NumberOfParts (>1)"

while getopts f:n: options 2> /dev/null
do
    case $options in
	f) file="$OPTARG"
	    ;;
	n) N=$OPTARG
	    ;;
    esac
done

if [ $N -le 1 -o -z "$file" ]
then
    echo "$usage"
    exit 1
elif [ ! -r "$file" ]
then
    echo "The file $file is not readable."
    exit 1
fi

size=`ls -l $file 2> /dev/null | awk '{print $5}' 2> /dev/null`
size=`expr $size / $N 2> /dev/null`

if [ $size -le 0 ]
then
    echo "The file $file is too small to be split."
    exit 1
fi

split -b $size $file $file 2> /dev/null

if [ $? -eq 0 ]
then
    echo "The file $file was split successfully."
else
    echo "An error occurred while attempting to split $file."
    exit 1
fi

exit 0
