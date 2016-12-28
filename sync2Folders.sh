#!/bin/bash

###
##
#  scripted by costi0n 4 ALGA Progect
#            - 28-12-2016 -
#  sync2Folders.sh /path/source /path/destination
##
###

SRC=$1
DST=$2
NOW=$(date +%d%H%M%S)
CWD=$(pwd)
LOG=$CWD"/sync2Folders.log"
RSYNC="/usr/bin/rsync"
IIbit="7"  # filtra le cloud in base al secondo bit del interfaccia di rete


#-------------------------------------------------------------------------
# per casi dove essistono più interfacce virutali
IFNAME=$(ip link show | grep "mtu" | grep "UP" |\
         grep "eth" | awk -F" " '{print $2}' |\
         awk -F":" '{print $1}')

# cerca il valore del secondobit sul interfaccia
VALUE=$(ifconfig $IFNAME | grep "inet" | grep -v "inet6" |\
        grep -v "127.0.0.1" | awk -F" " '{print $2}' |\
        awk -F":" '{print $2}' | awk -F"." '{print $2}')

# controlla il numero di parametri passati allo script deve essere 2
echo "---------------------------------------" >> $LOG
if [ "$#" -ne 2 ]
  then
    echo "$NOW > uno o più parametri mancanti" >> $LOG
  exit 255
fi

# fa un ulteriore controllo sul dato racolto nella variabile $VALUE
reg='^[0-9]+$'
if ! [[ $VALUE =~ $reg ]] ; then
   echo "$NOW > si è verificato un errore, esecuzione terminata !" >> $LOG
   exit 1
fi

# se il prercordo della destinazione non essiste lo crea
if [ ! -d "$DST" ]; then
  mkdir -p $DST
fi

# se il valore del secondo bit non è 7 ( quindi non cloud ) allora parte il sync
if [ "$VALUE" -ne "$IIbit" ]; then
   $RSYNC -avzh $SRC $DST
else
   echo 1
fi

