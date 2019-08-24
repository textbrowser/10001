#!/bin/sh
# This software was written by matrobriva (http://matrobriva.altervista.org, matrobriva@libero.it).

lessfile="`which less 2> /dev/null`"

if [ ! -r "$lessfile" -o ! -x "$lessfile" ]
then
    echo "Unable to locate less."
    exit 1
fi

unzipfile="`which unzip 2> /dev/null`"

if [ ! -r "$unzipfile" -o ! -x "$unzipfile"  ]
then
    echo "Unable to locate unzip."
    exit 1
fi

temp="/tmp/digilinux/odtreader"
mkdir -p $temp 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to create $temp."
    exit 1
fi

cp $1 $temp 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to copy $1 to $temp."
    exit 1
fi

cd $temp 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to change directory to $temp."
    exit 1
fi

unzip $1 1> /dev/null 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "unzip failure."
    exit 1
fi

if [ ! -r content.xml ]
then
    echo "Unable to read content.xml."
    exit 1
fi

sed -e 's/<[^>]*>//g' content.xml > $1.txt 1> /dev/null 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "sed failure."
    exit 1
fi

less $1.txt 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "less failure."
    exit 1
fi

cp $1.txt $HOME 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to copy $1.txt to your home directory."
    exit 1
fi

exit 0
