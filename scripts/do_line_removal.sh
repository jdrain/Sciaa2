#!/bin/zsh
#
# Author: Jason Drain
# Function: Starts at the root directory and goes through processing
#	    PDF files to PNGs
#

########################################################################
# IMPORTANT: root dir must have lineremoval and pdf2png-gray in it.    #
#	     lineremoval is built from leptonica-1.69 and pdf2gray is  #
#	     a script that comes with leptonica-1.71                   #
########################################################################

# get the root dir so we can easily return to it
ROOTDIR=$PWD

for i in ./*; do
    #if the directory has this construct
    if [[ -d $i/IndividualFiles/sorted/ ]] then;
	for j in $i/IndividualFiles/sorted/*; do
		#do for all dirs but all
		if [[ -d $j ]] && [[ $j != "$i/IndividualFiles/sorted/all" ]] then;
		    cd $j
		    #convert to a grayscale PNG
		    for k in ./*; do
			echo "doing pdf2png: $k" && $ROOTDIR/pdf2png-gray $k $k;
		    done;
		    #remove lines from the PNG
		    for k in ./*.png; do
			echo "doing lineremoval: $k" && $ROOTDIR/lineremoval $k $k;
		    done;
		    cd $ROOTDIR
		fi;
	done;
    fi;
done;
