#!/bin/bash
# longest-word2 : find longest string in a file
for i; do
    if [[ -r $i ]]; then
        max_word=
        max_len=0
        for j in $(strings $i); do
            len=$(echo $j | wc -c)
            if (( len > max_len )); then
                max_len=$len
                max_word=$j
            fi
            echo "call for j -----"
        done
        echo "$i: '$max_word' ($max_len characters)"
    fi
done
