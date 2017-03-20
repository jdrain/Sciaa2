#!/bin/zsh
#
# Author: Jason Drain
# Function: converts pdf files to tiff

for i in */; do if [[ $i != "all/" ]] then; 
	for j in $i/*.pdf;
	do IFS=". " read -r array <<< $j; 
	    str=""; 
	    str=${array[0]}; 
	    str+="."; 
	    str+=${array[1]}; 
	    str+="."; 
	    str+=${array[2]};
	    str+=".tiff"; 
	    convert -depth 8 -density 600 -background white -alpha Off $j $str; 
	done; 
    fi;
done;
