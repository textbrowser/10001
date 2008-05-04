#!/bin/csh -x

set BACKUP_DIR = /love/scsi/backup.d/shuts.d

if (! -d $BACKUP_DIR ) then
    mkdir $BACKUP_DIR
endif

cp -p *.1 $BACKUP_DIR/.
cp -p *.sh $BACKUP_DIR/.
cp -p backup.csh $BACKUP_DIR/.
cp -p README $BACKUP_DIR/.
cp -p VERSION $BACKUP_DIR/.
cp -p Makefile $BACKUP_DIR/.
