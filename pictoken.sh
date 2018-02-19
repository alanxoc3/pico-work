#!/bin/bash
# Counts the tokens of the file.

# Replace this line with your p8tool path
# p8tool can be found at:
# https://github.com/dansanderson/picotool
# Thanks to dansanderson!
picotool=~/repos/picotool/p8tool

tokenify ()
{
	local file="$1"
	local OUT_FILE=/tmp/$(basename $file).token.p8

	echo -e "pico-8 cartridge // http://www.pico-8.com\nversion 8\n__lua__\n-- \n-- \n\n" > $OUT_FILE
	cat $file >> $OUT_FILE

	# Now, for the magic.
	local TKN_STR=$(echo "--$($picotool stats $OUT_FILE | grep tokens)")
	local FILE_STR=$(head $file)

	echo $file: $TKN_STR
	if [[ "$FILE_STR" =~ ^---.* ]]; then
		sed -i '1s/^---.*$/'"$TKN_STR"'/' $file
	else
		sed -i '1s/^/'"$TKN_STR"'\n/' $file
	fi
}

for file in "$@"; do
	tokenify $file &
done

# I learned the below from:
# https://stackoverflow.com/questions/14254118/waiting-for-background-processes-to-finish-before-exiting-script
wait
