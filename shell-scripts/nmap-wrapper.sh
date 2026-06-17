#!/bin/bash

domain=""

echo "Please, write the domain: "
read domain

touch iplist.txt

nslookup $domain\
| grep -oP '\b(?:\d{1,3}\.){3}\d{1,3}\b'\
| echo  >> iplist.txt

#for ip in iplist.txt;do
#nmap -sT $ip
#done

