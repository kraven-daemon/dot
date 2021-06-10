#!/usr/bin/env sh

xdg(){
	if [ -z "$1" ]; then
		cat <<- MSG
		XDG_CONFIG_HOME and/or XDG_DATA_HOME
		are not set. check your env.

		see https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
		for more information.
		MSG
	fi
}

xdg "$XDG_CONFIG_HOME"
xdg "$XDG_DATA_HOME"

echo -e "In home"
jq --raw-output ".home[]" ftree.json

echo -e "In config"
jq --raw-output ".config[]" ftree.json


#FILES=$(ls -A)
#for line in $FILES; do
#	echo "$line"
#done


