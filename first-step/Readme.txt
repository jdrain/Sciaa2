1) First run the pdfsplitter.py, Put this file in the Input Files directory and run. 
2) Run pagelaout.py next. This is the main program which will create output in individual directories based on its different formats.
   First argument will be input file name and second argument will be the output directory(make sure you create one before)
   Along with the indivdual output directories, all the files are again written into "all" folder, which we use for the next step, to find out if any files are not recognized by the pagelaout program. 
3) Run cleaning.py, with first argument a text file containing input file list "./InputFiles/"and second argument will be a text file containing names of all the files in the "./OutputFiles/all" directory.
4) Run addingNames.py, This file needs to run only if you find some files which are not recognized by pagelaout.py and needs to be added manually, so file names are to be changed according to their format, so instead of manually doing it, this one will check all the folders and find the names which don't have the extension and add extensions based on the directory it is present in.

Note:
	Add the neccessary code to the nextpage.py for getting other pages of site form. Do not run this as part of first step initally, just run the below steps only for the first page of the site forms. Once we seperated handwritten and printed, include the other pages to them. Part of the reason is i have built the model by consdiering only the first page, if other other pages are included its accuracy gets affected.  

Run nextpage.py, which will coppy the second page for the 68-85 type of site form. Second page is only required for only one type of 68-85 type of file, it will only copy for that particular kind of file. 

Note: Some of the pdf's are recognized as LTImage instead of LTTextBox, because of that some of the site forms are not identified and extracted. These site forms have to be manually inserted in to the respective folders.
LTImage and LTTextBox are objects in pdfminer library, naturally text should be identified as LTTextBox, LTTextLine and images in the pdf as LTImage. But, for some of the pdf files are wholly recognized as LTImage because of which our script is not able to identified the site forms. These problem is more in few counties. 