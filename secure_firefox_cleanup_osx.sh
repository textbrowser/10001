#!/bin/sh
# Alexis Megas, 08/21/2007. A simple script that removes private Firefox files.
# Alexis Megas, 06/11/2008. Updated the list variable.
# Alexis Megas, 09/24/2008. Added new files.
# Alexis Megas, 10/24/2008. Changed sessionstore.js to sessionstore.*.

cd ~ 2> /dev/null

if [ $? -ne 0 ]
then
    echo "Unable to change the current working directory to your home directory."
    exit 1
fi

srm -frvz ./Library/Caches/Firefox 2> /dev/null

list="Cache Cache.Trash formhistory.dat downloads.rdf cookies.* history.dat minidumps places.* sessionstore.* urlclassifier*.* blocklist.xml bookmarkbackups signons3.txt *.sqlite"
firefox="./Library/Application Support/Firefox"

for file in $list
do
    find "$firefox" -name $file -exec srm -frvz {} \; 2> /dev/null
done

exit 0
