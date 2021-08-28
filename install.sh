#!/usr/bin/env sh

set -e


#colors
reset="[0m"
black="\e[1;30m"
#red = 31
#green = 32
#yellow = 33
#blue = 34
#magenta=35
#cyan 36
#white = 37

# jq is installed?
# files.json exist?
_canrun(){
    [ -x "$(command -v jq)" ] &&
        echo "jq : OK" || echo "jq is not installed"
    [ -e "files.json" ] &&
        echo "file : OK" || echo "files.json is missing"
    [ -n "$XDG_CONFIG_HOME" ] &&
        echo "path is a valid : $XDG_CONFIG_HOME" || echo "path is empty"
}

_linkable(){
    links="$(jq -r ".$1[]" files.json)"
    echo "$1"
    for link in $links
    do
        echo "$(realpath "$link") to $2/$link"
    done
}
# ln -s "$(realpath "$link") to $2/$link"

_parse(){
    iter=0
    key=""
    while :
    do
        key="$(jq -r "keys[$iter]" files.json)"
        echo "$iter:$key"
        case $key in
            "config" )
                echo "In $XDG_CONFIG_HOME"
                _linkable "$key" "$XDG_CONFIG_HOME"
                ;;
            "home" )
                echo "In $HOME/"
                _linkable "$key" "$HOME"
                ;;
            "data" )
                echo "In $XDG_DATA_HOME"
                echo "$(jq -r ".$key[]" files.json)"
                ;;
            "null" )
                echo "List done!"
                break;
                ;;
        esac
        iter="$(( iter + 1 ))"
    done
}

#_linkit awesome
_canrun && _parse

# for line in $FILES; do
# 	if [ -d $line ]; do
#         echo "$line"
#     fi
# done


