#!/bin/bash
# picwatch

# assumes current directory.
if ! ([ "$1" ]); then
	(>&2 echo "Need file to build.")
	exit
fi

DIRS=""
for f in ./src ./lib ./res.p8; do
	if [ -e $f ]; then
		DIRS="$f $DIRS"
	fi
done

inotifywait -e close_write,moved_to,create -m $DIRS |
while read -r directory; do
  echo "'$directory' was changed."
  make $1 > /dev/null
done