#!/bin/bash

#Author: Jason Drain
#Function: This script will run tesseract on .tiff files in a list of
#	   directories, which are specified by command line args

ARGV="$@"
ARGC="$#"

i="1"

echo "ARGC: "$ARGC
while [[ $i -lt $ARGC ]] 
	# check if dir exists
	do echo "$ARGV[1]" && if [[ -d "$ARGV[$i]" ]]; then
		# run tesseract for .tiff files in that dir
		echo "$ARGV[$i] is dir"
		cd "$ARGV[$i]"
		for j in *.tiff;
			do tesseract "$j" "$j";
		done;
		cd ..
	fi
	i=$(($i+1))
done
echo "test"
