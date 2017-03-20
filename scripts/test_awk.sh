#!/bin/bash

for i in *.txt;
do 
	j="$(echo $i | awk '{split($0,f,".")} END { print f[1] }')"
	echo "writing $i to $j";
	cat $i >> $j;
done;
