#!/bin/bash
###
##
# scripted by costi0n
# preparazione VM server LAMP debian minimal
##
###

apt-get -y update && apt-get -y upgrade
apt-get -y install vim-nox apache2 dnsutils mysql-server mysql-client php5 php-pear php5-mysql php5-gd php5-cli php5-ldap php5-imap php5-curl open-vm-tools
