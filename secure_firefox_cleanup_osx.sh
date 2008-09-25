#!/bin/sh
# Alexis Megas, 08/21/2007. A simple script that removes private Firefox files.
# Alexis Megas, 06/11/2008. Updated the list variable.
# Alexis Megas, 09/24/2008. Added new files.

cd ~

if [ $? -ne 0 ]
then
    echo "Unable to change directory to your home."
    exit 1
fi

srm -frvz ./Library/Caches/Firefox

list="Cache Cache.Trash formhistory.dat downloads.rdf cookies.* history.dat minidumps places.* sessionstore.js urlclassifier*.* blocklist.xml bookmarkbackups signons3.txt *.sqlite"
firefox="./Library/Application Support/Firefox"

for file in $list
do
  find "$firefox" -name $file -exec srm -frvz {} \; 2> /dev/null
done

exit 0
