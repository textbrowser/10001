#!/usr/bin/env sh
# Alexis Megas.

rm -f pi-temperature.txt

while
    echo $(date '+%Y-%m-%d:%H%M%S%N'; vcgencmd measure_temp) >> \
	 pi-temperature.txt
    sleep 0.25
do true; done

exit 0
