#!/usr/bin/env sh


echo -e "In home"
jq --raw-output ".home[]" ftree.json

echo -e "In config"
jq --raw-output ".config[]" ftree.json


#FILES=$(ls -A)
#for line in $FILES; do
#	echo "$line"
#done


