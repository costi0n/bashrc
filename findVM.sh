#!/bin/bash


net='10.169.15.'
for i in $(seq 255)
do
  echo | nc -nvw1 $net$i 902 | if grep -iq "VMware"
  then
    echo "$net$i looks like an ESX(i) host."
  else
    echo "$net$i does not look like an ESX(i) host."
  fi
done
