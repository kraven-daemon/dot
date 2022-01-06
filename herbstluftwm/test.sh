#!/usr/bin/env sh

set -euf

# -r to ignore escape except \n
while read -r line
do
    # line => non-empty and not a comment
    if [ -n "$line" ] && ! [ "$(echo $line | cut -c 1)" = "#" ];then
        left="$(echo $line | sed -E 's/^(\S+).*/\1/')"
        right="$(echo $line | sed -E '/$left/!d')"
        # echo $left
        echo $right
    fi

done < attributs


