#!/bin/bash

#Author: Jason
#Function: Put together multiple pages of a form based on the first part
#	   of the filename

for i in *.txt;
do 
	j="$(echo $i | awk '{split($0,f,".")} END { print f[1] }')"
	echo "writing $i to $j";
	cat $i >> $j;
done;
