#!/bin/bash
# upper line defines the interpreter to be used (bash in this case)

# Check if the number of arguments is not equal to 2
if [ $# -ne 2 ]; then
    echo "$0 <word.list> <passwords>"
    exit 1  # Exit the script if the arguments are not correct
fi

# Iterate through every line of the file in the first parameter $1 (word.list)
# IFS => sets internal field seperator to empty string otherwise read cmd could have unexpected behavior
# -r => backslashes will be read literally
while IFS= read -r word; do
    
# Getting the hash for the current word in the wordlist
    # echo -n => displays the password without newline
    # md5sum => calculates md5 hash
    # cut -d " " -f 1 => extracts the calculated hash value (delimiter " "; field 1)
    hash=$(echo -n "$word" | md5sum | cut -d " " -f 1)

    # Searches for the calculated hash in the passwordlist ($2) and counts the lines where it occurs.
    # Afterwards, saves the count, word, and hash into a file (tmp.txt)
    echo "$(grep -c "$hash" "$2"), \"$word\", \"$hash\"" >> "tmp.txt"

done < "$1"  # Input redirection for the while loop

# Sorts the lines in tmp.txt based on the occurrence count.
# -t => separates the line into fields with the delimiter being ','
# -nrk => comparison is made as numeric value and then reversed so the most occurred one is at the top
# It should only be sorted by the first field.
sort -t "," -nrk1,1 "tmp.txt"

rm "tmp.txt"


