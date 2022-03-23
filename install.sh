#!/usr/bin/env sh
# depends: jq
set -eu

SRC='list.json'

reset='\033[0m'
## regular
#red="\033[00;31m"
#green="\033[00;32m"
#yellow="\033[00;33m"
#blue="\033[00;34m"
#purple="\033[00;35m"
#cyan="\033[00;36m"
#lightgrey="\033[00;37m"
## Bold
bred="\033[01;31m"
bgreen="\033[01;32m"
byellow="\033[01;33m"
#bblue="\033[01;34m"
#bpurple="\033[01;35m"
#bcyan="\033[01;36m"
#white="\033[01;37m"

# test wrapper, with colors
# _test [flags] [file] [error message] [minimum char width for space padding] => return 0|1 to make it stoppable
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

# return the caracter width of the longest word of a list
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

# iterate over list 
# ( key, destination )
_linkable(){
    list="$(jq -r ".$1[]" ${SRC})"
    for file in $list
    do
		FILE="$(realpath "${file}")"
		DEST="${2}"
		printf "FILE : %s\nDESTINATION -> %s\n" "${FILE}" "${DEST}/${file}"
		echo "LINKING ..."
		if ln -s "${FILE}" "${DEST}"; then
				printf "%bSucess%b linking %s to %s\n" "${bgreen}" "${reset}" "${FILE}" "${DEST}"
		else
				printf "Want to %boverride%b? y/n : " "${byellow}" "${reset}"
				read  -r answer
				case $answer in
					y)
						echo "removing ${DEST}/${file}"
						rm "${DEST}/${file}"
						ln -s "${FILE}" "${DEST}" 
					;;
					Y)
						echo "removing ${DEST}/${file}"
						rm "${DEST}/${file}"
						ln -s "${FILE}" "${DEST}" 
					;;
					*)
						;;
				esac

		fi
    done
}

# iterate over keys
_parse(){
    index=0
    key=""
    while :
    do
        key="$(jq -r "keys[$index]" ${SRC})"
        printf "\t%s :\t%s\n" "${index}" "${key}"
        case $key in
            "config" )
                echo "In $XDG_CONFIG_HOME"
                _linkable "$key" "$XDG_CONFIG_HOME"
                ;;
            "home" )
                echo "In $HOME"
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
        index="$(( index + 1 ))"
    done
}

_parse
