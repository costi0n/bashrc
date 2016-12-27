#!/bin/bash

###
##
#  scripted by costi0n
#  sync2Folders.sh /path/source /path/destination
##
###

SRC=$1
DST=$2

RSYNC="/usr/bin/rsync"


if [ "$#" -ne 2 ]
  then
    echo -en "uno o più parametri mancanti\n"
  exit 255
fi

$RSYNC -avzh $SRC $DST

