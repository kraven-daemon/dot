#!/usr/bin/env sh
# depends: jq
set -eu

JSON='list.json'

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
    list="$(jq -r ".$1[]" ${JSON})"
    for file in $list
    do
        clear
		FILE="$(realpath "${file}")"
		DEST="${2}"
		printf "FILE : %s\nDESTINATION -> %s\n" "${FILE}" "${DEST}/${file}"
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

# iterate over a sequence of keys
_parse(){
    len=$(jq 'keys | length' ${JSON})
    for index in $(seq 0 "$(( len - 1 ))")
    do
        key="$(jq -r "keys[$index]" ${JSON})"
        printf "%s : %s\n" "${index}" "${key}"
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
        esac
    done
}

_parse
echo "Done"
exit 0
