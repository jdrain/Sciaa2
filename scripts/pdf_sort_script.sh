#!/bin/zsh

#run the pdfsort python script over multiple dirs

#array of dir names
#declare -a arr=(
#	"Abbeville"
#	"Anderson"
#	"BARNWELL"
#	"Calhoun"
#	"Laurens"
#	"Spartanburg"
#	)

declare -a arr=(
	    "Calhoun"
	    )

declare OUTDIR="sorted"

#run the script for each directory
for i in ${arr[@]};
    for j in $i/IndividualFiles/*.pdf;
	do python pagelayout.py $j $i/IndividualFiles/$OUTDIR; done;
