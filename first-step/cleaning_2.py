#rewriting the cleaning file to better fit my needs

import os, sys

#arg1 is the input file path
#arg2 is the output file path

in_path = sys.argv[1]
out_path = sys.argv[2]

in_list = [f.split(".")[0] for f in os.listdir(in_path)]
out_list = [f.split(".")[0] for f in os.listdir(out_path)]

in_list.sort()
out_list.sort()

#print both lists
print("\nin list: ")
for i in  in_list:
    print(i)

print("\nout list: ")
for i in out_list:
    print(i)

#print the difference set
diff = list(set(in_list) - set(out_list))
print("\ndifference list: ")
for i in diff:
    print(i)
