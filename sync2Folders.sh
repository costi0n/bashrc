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
CWD=$(pwd)
LOG=$CWD"/sync2Folders.log"
RSYNC="/usr/bin/rsync"
IIbit="7"

now () {
   date +[%d-%m-%Y][%H:%M:%S]
}


log () {
  echo -en $(now) "> $1\n" >> $LOG
}

log "avvio procedura di sincronizzazione"
#-------------------------------------------------------------------------
# per casi dove essistono più interfacce virutali
IFNAME=$(ip link show | grep "mtu" | grep "UP" |\
         grep "eth" | awk -F" " '{print $2}' |\
         awk -F":" '{print $1}')
log "trovato l'interfaccia $IFNAME"

# cerca il valore del secondobit sul interfaccia
VALUE=$(ifconfig $IFNAME | grep "inet" | grep -v "inet6" |\
        grep -v "127.0.0.1" | awk -F" " '{print $2}' |\
        awk -F":" '{print $2}' | awk -F"." '{print $2}')
log "trovato l'ip $VALUE"

# controlla il numero di parametri passati allo script deve essere 2
if [ "$#" -ne 2 ]
  then
    log "uno o più parametri mancanti \n\n\n\n"
  exit 255
fi

# controlla se la variabile VALUE contiene un valore da 0 a 255
octet="(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"
if ! [[ $VALUE =~ ^$octet$ ]]; then
   log "si è verificato un errore, esecuzione terminata !"
   log "var VALUE = $VALUE"
   log "\n\n\n\n"
   exit 1
fi

# se il prercordo della destinazione non essiste lo crea
if [ ! -d "$DST" ]; then
  log "non ho trovato il percorso alla cartella $DST, creo tutta la struttura"
  mkdir -p $DST
fi

# se il valore del secondo bit non è 7 ( quindi non cloud ) allora parte il sync
if [ "$VALUE" -ne "$IIbit" ]; then
   $RSYNC -avzh $SRC $DST
   log "procedura di sincronizzazione finita\n\n\n\n"
else
   log "questo server sembra essere un installazione cloud, esco dalla procedura\n\n\n\n"
   echo 1
fi
