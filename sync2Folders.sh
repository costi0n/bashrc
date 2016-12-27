#!/bin/bash

###
##
#  scripted by costi0n
#  sync2Folders.sh /path/source /path/destination
##
###

SRC=$1
DST=$2
NOW=$(date +%d%H%M%S)
CWD=$(pwd)
LOG=$CWD"/sync2Folders.log"
RSYNC="/usr/bin/rsync"
IIbit="7"

#-------------------------------------------------------------------------
VALUE=$(ifconfig | grep "inet" | grep -v "inet6" | \
        grep -v "127.0.0.1" | awk -F" " '{print $2}' |\
        awk -F":" '{print $2}' | awk -F"." '{print $2}')


echo "---------------------------------------" >> $LOG
if [ "$#" -ne 2 ]
  then
    echo "$NOW > uno o più parametri mancanti" >> $LOG
  exit 255
fi


reg='^[0-9]+$'
if ! [[ $VALUE =~ $reg ]] ; then
   echo "$NOW > si è verificato un errore, esecuzione terminata !" >> $LOG
   exit 1
fi

if [ "$VALUE" -ne "$IIbit" ]; then
   exit 1
else
   $RSYNC -avzh $SRC $DST
fi

