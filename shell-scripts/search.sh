#!/bin/bash

dir=""
text=""
filetype=""

echo "directory: "
read dir 
echo "text: "
read text
echo "filetype: "
read filetype

echo "Text search in: $dir in process "

for file in "$dir"/*."$filetype";do 

if grep -q "$text" "$file";then 
echo "Result: $text store in $file" 
fi

done 
