import sys,os,csv,glob

#list1=glob.glob("./InputFiles/")
#list2=glob.glob("./OutputFiles/all/");
#for each_file in list1:
#	if not (each_file in list2):
#		print "%s not found",%each_file
#first folder ... the folder in which to be checked file names are present(Individual files)
name1 = sys.argv[1]
with open(name1,'r') as myfile1:
	data1 = myfile1.read()
file_names1 = data1.split('\n')


#second folder ... the folder in which orginal file names are present ...
#we will check all the files names with this file names.... all the file
#names are made as string called result.(Input files)

name2 = sys.argv[2]
with open(name2,'r') as myfile2:
	data2 = myfile2.read()
file_names2 = data2.split('\n')

result = ""

for file_name2 in file_names2:
	n1 = ''.join(file_name2)
	n2 = n1.split('.')
	n3 = ''.join(n2[0])
	if len(n3) == 8:
		result = result + n3


for file_name1 in file_names1:
	n1 = ''.join(file_name1)
	n2 = n1.split('.')
	n3 = ''.join(n2[0])
	if len(n3) == 8:
		#print onlyfilename1
		#print file_names2[i]
		if n3 not in result:
			print n3 + " : not present...!"
		#else:
			#print n3 + " : present...!"
