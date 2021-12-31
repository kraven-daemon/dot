#!/usr/bin/env sh

set -e


SRC="list.json"


reset="\033[0m"
## regular
red="\033[00;31m"
green="\033[00;32m"
#yellow="\033[00;33m"
#blue="\033[00;34m"
#purple="\033[00;35m"
#cyan="\033[00;36m"
#lightgrey="\033[00;37m"
## Bold
bred="\033[01;31m"
bgreen="\033[01;32m"
#byellow="\033[01;33m"
#bblue="\033[01;34m"
#bpurple="\033[01;35m"
#bcyan="\033[01;36m"
#white="\033[01;37m"

coltest(){
    crap=1
    while [ $crap -lt 8 ]
    do
        printf "%b hello %b\t%b bold-hello %b\n" "\033[00;3${crap}m" "$reset" "\033[01;3${crap}m" "$reset"
        crap=$(( crap + 1 ))
    done
}


# test wrapper, see: man test
_test(){
    flag=$1
    file=$2
    errmsg=$3
    align=$4
    retstatus=0
    if test "$flag" "$file";then
        printf "%-*s : %bOK%b\n" "${align}" "${file}" "${bgreen}" "${reset}"
    else
        printf "%-*s : %bFAIL%b\n%s : %s\n" "${align}" "${file}" "${bred}" "${reset}" "${file}" "${errmsg}"
        printf "Exiting...\n"
        retstatus=1
    fi
    return $retstatus
}

# return the caracter width of the longest word
_getlongest(){
    long=0
    next=0
    for word in $1;do
        next=$(printf "%s" "${word}" | wc -m)
        if [ $long -lt "$next" ];then
            long=$next
        fi
    done
    echo "$long"
}


_canrun(){
    retstatus=0
    # -x, -e, -n
    depend_on="$(command -v jq) ${SRC} ${XDG_CONFIG_HOME} ${XDG_DATA_HOME}"
    alignto=$(_getlongest "$depend_on")
    echo "$depend_on : $alignto"

    # flag file errmsg align
    _test "-x" "$(command -v jq)" "executable not found" "$alignto"
    _test "-e" "${SRC}" "file not found" "$alignto"
    _test "-n" "$XDG_CONFIG_HOME" "variable undefined" "$alignto"
    _test "-n" "$XDG_DATA_HOME" "variable undefined" "$alignto"
}

# link the ( $1 = key  => source file )
#       to ( $2 = path => destination )
_linkable(){
    list="$(jq -r ".$1[]" ${SRC})"
    for file in $list
    do
        echo "$(realpath "${file}")\v -> ${2}/${file}"
    done
}
# ln -s "$(realpath "$link") to $2/$link"

_parse(){
    iter=0
    key=""
    while :
    do
        key="$(jq -r "keys[$iter]" ${SRC})"
        printf "\t%s :\t%s\n" "${iter}" "${key}"
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
                _linkable "$key" "$XDG_DATA_HOME"
                ;;
            "local" )
                echo "In $HOME/.local"
                _linkable "$key" "$HOME/.local"
                ;;
            "null" )
                echo "List done!"
                break
                ;;
        esac
        iter="$(( iter + 1 ))"
    done
}

_canrun &&
_parse

# for line in $FILES; do
# 	if [ -d $line ]; do
#         echo "$line"
#     fi
# done


