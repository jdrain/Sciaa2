#!/bin/zsh

#run the pdfsplitter python script over multiple dirs

#array of dir names, passed by command line
declare -a arr=("Bamberg")

#put the pdfsplitter script in each dir and run it
for i in ${arr[@]};
    do cp "first-step/pdfsplitter.py" $i && cd $i;
    for j in *.pdf; do python pdfsplitter.py $j; done;
    cd "..";
done;
