#!/bin/bash

if [ $# -lt 3 ] || [ "$#" -gt 4 ]; then
    echo "$0 <word.list> <hashes> <sha1 or md5> [<list all results = -1, list only successful results = 0>]"
    exit 1
fi

if [ ! -f $1 ]  ||  [ ! -f $2 ]; then
    echo "Either $1 or $2 does not exist!"
    exit 1
fi

if [ ! "$3" != "sha1" ] && [ ! "$3" != "md5" ]; then
	echo "Specify the hash compare mode as either sha1 or md5 and not $3."
    exit 1
fi

if [ $4 -eq -1 ]

comMode="$3sum"
listVal=${4:-0}

while IFS= read -r word; do
    hash=$(echo -n "$word" | $comMode | cut -d " " -f 1)
    echo "$(grep -c "$hash" "$2"), \"$word\", \"$hash\""
done < "$1" | awk -F, -v listVal="$listVal" '$1 >= listVal' | sort -t "," -nrk1,1


