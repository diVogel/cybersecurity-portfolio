#!/bin/bash

domain=""
ip=""

echo "Please, write some domain: "
read domain 

if ["$domain" != " "];then
touch ipget.txt < nslookup domain
else
echo "$domain is not found"
fi
