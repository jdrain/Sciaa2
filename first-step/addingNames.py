#Some of the files are not recognized by the pdfminer. All those forms are copied manually into their respective folders, 
#but the names at the end are not added for them like 38AN0011.page-5.pdf is the file name but it needs to be changed to 38AN0011.page-5.68-1.pdf.
#below program will automatically goes to each of the folder and changes the file name according to the folder in which they are present.
import os
basedir = "./OutputFiles/"
dirlist=os.listdir(basedir)
for each_dirlist in dirlist:
	pdflist=os.listdir(basedir+each_dirlist)
	##print "*************************************"
	#print " "
	#print " "
	for each_pdflist in pdflist:
		if not each_dirlist in each_pdflist:
			part=each_pdflist.split(".")
			new_name=""
			new_name=part[0]+"."+part[1]+"."+each_dirlist+".pdf"
			print new_name
			dirname = basedir+each_dirlist+"/"
			current_file = dirname + each_pdflist
			destination_file = dirname + new_name
			os.rename(current_file, destination_file );

