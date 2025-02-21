#!/usr/bin/env sh

# Alexis Megas.

if [ -z "$(which vcgencmd)" ]
then
    echo "Missing vcgencmd."
    exit 1
fi

rm -f pi-temperature.txt

while
    echo $(date '+%Y-%m-%d:%H%M%S%N' ; vcgencmd measure_temp 2>/dev/null) >> \
	 pi-temperature.txt
    sleep 0.25
do true
done

exit 0
