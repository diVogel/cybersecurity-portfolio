#!/bin/bash

domain=""

echo "Please, write the domain: "
read domain 

nslookup domain\
| grep -i "server"\
| IP= awk '{print $2}' 
