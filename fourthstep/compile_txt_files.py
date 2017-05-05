import os
import sys

"""
arg1: input dir
arg2: new output dir
"""


# produce the new file name
def get_new_file_name(old):
    tmp = old.split(".")
    new = ".".join([tmp[0],tmp[2]])
    return new

# compile the files into one
def compile_files(input_ls,output_dict,dr):
    for i in input_ls:
        n = get_new_file_name(i)
        if output_dict[n] != None:
            with open(dr+i,'r') as f:
                for line in f:
                    output_dict[n].append(line)

# get new file names
def get_file_names(files):
    new_files = []
    for i in files:
        n = get_new_file_name(i)
        if n not in new_files:
            new_files.append(n)
    return new_files

#write the compiled data to new files
def write_files(d,dr):
    for i in d.keys():
        with open(dr+i,'w+') as f:
            for line in d[i]:
                f.write(line)

#main method
if __name__ == '__main__':
    files = os.listdir(sys.argv[1])
    new_files = get_file_names(files)
    d = {i:[] for i in new_files}
    compile_files(files,d,sys.argv[1])
    os.mkdir(sys.argv[2])
    write_files(d,sys.argv[2])
