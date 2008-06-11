#!/bin/sh
# Alexis Megas, 08/21/2007. New script.
# A simple script that removes private Firefox files.
# Alexis Megas, 06/11/2008. Update.
# Updated the list variable.

cd ~

if [ $? -ne 0 ]
then
    echo "Unable to change to your home directory."
    exit 1
fi

srm -frvz ./Library/Caches/Firefox

list="Cache Cache.Trash formhistory.dat downloads.rdf cookies.sqlite cookies.txt history.dat minidumps places.sqlite places.sqlite-journal sessionstore.js urlclassifier2.sqlite blocklist.xml bookmarkbackups signons3.txt"
firefox="./Library/Application Support/Firefox"

for file in $list
do
  find "$firefox" -name $file -exec srm -frvz {} \; 2> /dev/null
done

exit 0
