#!/bin/sh
# This software was written by matrobriva (http://matrobriva.altervista.org, matrobriva@libero.it).

if [ ! -x "`which less 2> /dev/null`" ]
then
    echo "Unable to locate less."
    exit 1
fi

if [ ! -x "`which unzip 2> /dev/null`" ]
then
    echo "Unable to locate unzip."
    exit 1
fi

temp=/tmp/digilinux/odtreader

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
cp $1.txt $HOME 2> /dev/null

if [ ! $? -eq 0 ]
then
    echo "Unable to copy $1.txt to $HOME."
    exit 1
fi

exit 0
