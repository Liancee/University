#!/bin/bash

if [ $# -ne 2 ]; then
    echo "$0 <word.list> <hashes>"
    exit 1
fi

if [ ! -f $1 ]  ||  [ ! -f $2 ]; then
    echo "Either $1 or $2 does not exist!"
    exit 1
fi    

while IFS= read -r word; do
    hash=$(echo -n "$word" | md5sum | cut -d " " -f 1)
    echo "$(grep -c "$hash" "$2"), \"$word\", \"$hash\""

done < "$1" | sort -t "," -nrk1,1


