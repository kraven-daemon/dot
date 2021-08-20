#!/usr/bin/env sh

FILES="$(ls -A)"
for line in $FILES; do
	if [ -d $line ]; do
        echo "$line"
    fi
done


