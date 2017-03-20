from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfpage import PDFTextExtractionNotAllowed
from pdfminer.pdfinterp import PDFResourceManager
from pdfminer.pdfinterp import PDFPageInterpreter
from pdfminer.pdfdevice import PDFDevice
from pdfminer.layout import LAParams, LTTextBox, LTTextLine, LTFigure, LTImage, LTTextBoxHorizontal
from pdfminer.converter import PDFPageAggregator
from pyPdf import PdfFileWriter, PdfFileReader
from fuzzywuzzy import fuzz
import sys
import os
from shutil import copyfile

#This program is for copying the the second page of a 68-85 type of file from the indivdualfiles folder. One particular type of the site forms contins information in the second page alswell to handel that
#we are seperately writing this program which copies for that particular type of file only.

#destination is a RELATIVE filepath; can be constructed if doesn't exist
if len(sys.argv) != 2:
	print("args should be of the form: <input file> <destination "
	"directory>")
	exit()

# Open a PDF file.
filename = sys.argv[1]
fp = open(filename, 'rb')
# Create a PDF parser object associated with the file object.
parser = PDFParser(fp)
# Create a PDF document object that stores the document structure.
# Supply the password for initialization.
document = PDFDocument(parser)
# Check if the document allows text extraction. If not, abort.
if not document.is_extractable:
	raise PDFTextExtractionNotAllowed
# Create a PDF resource manager object that stores shared resources.
rsrcmgr = PDFResourceManager()
# Set parameters for analysis.
laparams = LAParams()
# Create a PDF page aggregator object.
device = PDFPageAggregator(rsrcmgr, laparams=laparams)
# Create a PDF interpreter object.
interpreter = PDFPageInterpreter(rsrcmgr, device)
# Process each page contained in the document.

k=0

inputpdf = PdfFileReader(open(filename, "rb"))
for page in PDFPage.create_pages(document):
	interpreter.process_page(page)
	# receive the LTPage object for the page.
	layout = device.get_result()
	#print "***************************************************************"
	#print "***************************************************************"
	#print "***************************************************************"
	#def parse_layout(layout):
	for each_layout in layout:
		#print "in the if block"
		#print each_layout.get_text().upper()
		if isinstance(each_layout,LTTextBox) or isinstance(each_layout,LTTextBoxHorizontal) or isinstance(each_layout,LTTextLine) :
			#print type(each_layout)
			#print each_layout.get_text().upper()
			#print "in the if block"
			
			
			site = fuzz.ratio("SITE CHARACTERISTICS",each_layout.get_text().upper())
			if site > 70:
				print "site %f " %site
				k=k+1
			
			matcol = fuzz.ratio("HUMAN SKELETAL REMAINS:",each_layout.get_text().upper())
			if matcol > 70:
				#print "matcol %f " %matcol
				k=k+1
			matob = fuzz.ratio("SITE DEPTH:",each_layout.get_text().upper())
			if  matob > 70:
				#print "matob %f " %matob
				k=k+1
				
				

# It checks for the files which do not contain the above text and copies the next page of that file from the individual files

if (k==0) :
	
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	#print "file name 0%s" %str1
	fullname = str1.split('/')
	names = fullname[3].split('.')
	pagenumber = names[1].split('-')
	number = int(pagenumber[1])
	number = number + 1
	pagenumber[1] = str(number)
	desired_filename = names[0]+"."+pagenumber[0]+"-"+pagenumber[1]+".pdf"
	output_filename = names[0]+"."+pagenumber[0]+"-"+pagenumber[1]+ ".68-85"+".pdf"
	src = "./IndividualFiles/"+desired_filename
	dest = "./OutputFiles/68-85/"+output_filename
	#copying the file from the individualfiles folder to the output folder
	copyfile(src, dest)
		




