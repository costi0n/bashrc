#!/bin/bash

read -p "inserire il nome del sito/dominio [ENTER] ": site
site=${site:-default.com}

read -p "percorso siteroot [/var/www/] ": siteroot
siteroot=${siteroot:-/var/www/}$site

logs=$siteroot"/logs"
html=$siteroot"/html"

mkdir -p $logs
mkdir -p $html

echo -en "creato il percorso "$logs" e "$html"\n"


