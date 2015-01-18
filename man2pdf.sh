#!/bin/sh
# man2pdf was written by matrobriva (http://matrobriva.altervista.org, matrobriva@libero.it).

ps2pdffile="`which ps2pdf 2> /dev/null`"

if [ ! -r "$ps2pdffile" -o ! -x "$ps2pdffile" ]
then
    echo "Unable to locate ps2pdf."
    exit 1
fi

man -t $1 > $1.ps 2> /dev/null && ps2pdf $1.ps 2> /dev/null

if [ ! $? -eq 0 ]
then
    rm -f $1.ps
    exit 1
fi

rm -f $1.ps

echo "The manual for $1 was converted to a PDF file and placed in the current directory."
exit 0
