#!/bin/sh
# Alexis Megas, 08/21/2007. New script.
# A simple script that removes private Firefox files.

cd ~

if [ $? -ne 0 ]
then
    echo "Unable to change to your home directory."
    exit 1
fi

srm -frvz ./Library/Caches/Firefox

list="Cache.Trash formhistory.dat downloads.rdf Cache cookies.txt history.dat sessionstore.js urlclassifier2.sqlite blocklist.xml bookmarkbackups"
firefox="./Library/Application Support/Firefox"

for file in $list
do
  find "$firefox" -name $file -exec srm -frvz {} \; 2> /dev/null
done

exit 0
