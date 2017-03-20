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

#destination is a RELATIVE filepath; can be constructed if doesn't exist
if len(sys.argv) != 3:
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

i=j=k=m=n=o=p=q=r=s=t=u=v=w=x=y=z=z1=0

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
			scsir = fuzz.ratio("SOUTH CAROLINA SITE INVENTORY RECORD",each_layout.get_text().upper())
			if scsir > 65:
				#print "env %f " %env
				z1=z1+1
			underwater = fuzz.ratio("UNDERWATER SITES ONLY",each_layout.get_text().upper())
			if underwater > 65:
				#print "env %f " %env
				z=z+1
			rev_85 = fuzz.ratio("( 68-1 REV. 85 )",each_layout.get_text().upper())
			if rev_85 > 75:
				#print "env %f " %env
				x=x+1	
			rev_2015 = fuzz.ratio("(68-1 REV. 2015)",each_layout.get_text().upper())
			if rev_2015 > 75:
				#print "rev_2015 %f " %rev_2015
				y=y+1	
			env = fuzz.ratio("ENVIRONMENT AND LOCATION",each_layout.get_text().upper())
			if env > 70:
				#print "env %f " %env
				i=i+1
			gen = fuzz.ratio("GENERAL INFORMATION",each_layout.get_text().upper())
			if gen > 70:
				#print "gen %f " %gen
				i=i+1
			site = fuzz.ratio("SITE CHARACTERISTICS",each_layout.get_text().upper())
			if site > 70:
				#print "site %f " %site
				k=k+1
			arch = fuzz.ratio("ARCHEOLOGICAL DESCRIPTION",each_layout.get_text().upper())
			if arch > 70:
				#print "arch %f " %arch
				j=j+1
			matcol = fuzz.ratio("MATERIAL COLLECTED",each_layout.get_text().upper())
			if matcol > 70:
				#print "matcol %f " %matcol
				m=m+1
			matob = fuzz.ratio("MATERIAL OBSERVED:",each_layout.get_text().upper())
			if  matob > 70:
				#print "matob %f " %matob
				m=m+1
			rev_68_74 = fuzz.ratio("68-1 REV. 74",each_layout.get_text().upper())
			if  rev_68_74 > 60:
				#print "matob %f " %matob
				s=s+1
			rev_68_org = fuzz.partial_ratio("68-1",each_layout.get_text().upper())
			if  rev_68_org > 60:
				#print "matob %f " %matob
				t=t+1
			ptp = fuzz.ratio("PRELIMINARY TEST PITS",each_layout.get_text().upper())
			if  ptp > 70:
				#print "matob %f " %matob
				v=v+1
			sc = fuzz.ratio("SURFACE COLLECTION",each_layout.get_text().upper())
			if  sc > 70:
				#print "matob %f " %matob
				v=v+1
			rev_68_78 = fuzz.ratio("68-1 REV. 78",each_layout.get_text().upper())
			if  rev_68_78 > 60:
				#print "matob %f " %matob
				u=u+1
			highway = fuzz.ratio("HIGHWAY ARCHEOLOGY SITE FORM",each_layout.get_text().upper())
			if highway > 70:
				n=n+1
			pu = fuzz.ratio("PRESENT USE",each_layout.get_text().upper())
			if pu > 70:
				o = o+1
			gsv = fuzz.ratio("GROUND SURFACE VISIBILITY",each_layout.get_text().upper())
			if gsv > 70:
				o=o+1
			mic = fuzz.ratio("MICROZONE:",each_layout.get_text().upper())
			if mic > 70:
				p = p+1
			ads = fuzz.ratio("ASSOCIATED DRIANAGE SYSTEM:",each_layout.get_text().upper())
			if ads > 70:
				p = p + 1
			environment = fuzz.ratio("ENVIRONMENT:",each_layout.get_text().upper())
			if environment > 70:
				q = q+1
			description = fuzz.ratio("DESCRIPTION:",each_layout.get_text().upper())
			if description > 70:
				q = q+1
			condition = fuzz.ratio("CONDITION:",each_layout.get_text().upper())
			if condition > 70:
				q = q+1
			russell = fuzz.ratio("RUSSELL ARCHEOLOGICAL PROJECT SITE SURVEY FORM",each_layout.get_text().upper())
			if russell > 70:
				w = w+1	
			modern = fuzz.ratio("MODERN LAND USE:",each_layout.get_text().upper())
			if modern > 70:
				w = w+1
			apparent = fuzz.ratio("APPARENT RESEARCH POTENTIAL:",each_layout.get_text().upper())
			if apparent > 70:
				w = w+1		
		#elif isinstance(each_layout,LTFigure):
			#print "LTFigure"
			#print each_layout.get_text().upper()
		#else:
		#	print "else"		

	#parse_layout(layout)				

#print "i value %d " %i
#print "j value %d " %j
#print "k value %d " %k
#print "y value %d " %y
#print "n value %d " %n
#print "o value %d " %o
#print "p value %d " %p
#print "q value %d " %q
#print "s value %d " %s
#print "t value %d " %t
#print "u value %d " %u
#print "v value %d " %v
#print "w value %d " %w
#making sure that /all/ directory is alredy present. If not we are creating the directory here.
if os.path.isdir(sys.argv[2] + "/all/") == False:
		os.makedirs(sys.argv[2] + "/all/")

if (i==2 or k==1 or j==1) and (x==1):
	new_dir = sys.argv[2] + "/68-85/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	#print "file name 0%s" %str1
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".68-85.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder
	with open(new_dir_all+names[0]+"."+names[1]+".68-85.pdf", "wb") as outputStream:
		output.write(outputStream)	

#if (i==2 or k==1 or j==1) and (y==1):
#	new_dir = sys.argv[2] + "/68-2015/"
#	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
#	if os.path.isdir(new_dir) == False:
#		os.makedirs(new_dir)
#	output = PdfFileWriter()
#	output.addPage(inputpdf.getPage(0))
#	str1 = ''.join(filename)
	#print "file name 0%s" %str1
#	fullname = str1.split('/')
#	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
#	with open(new_dir+names[0]+"."+names[1]+".68-2015.pdf", "wb") as outputStream:
#		output.write(outputStream)
	#writing the file to the all folder
#	with open(new_dir_all+names[0]+"."+names[1]+".68-2015.pdf", "wb") as outputStream:
#		output.write(outputStream)

#68-1 original type of images
if (i==2 or k==1 or j==1) and (z==1):
	new_dir = sys.argv[2] + "/68-79/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	#print "file name 0%s" %str1
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".68-79.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder	
	with open(new_dir_all+names[0]+"."+names[1]+".68-79.pdf", "wb") as outputStream:
		output.write(outputStream)	

if m>0 and t >=0:
	new_dir = sys.argv[2] + "/68-1/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".68-1.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder	
	with open(new_dir_all+names[0]+"."+names[1]+".68-1.pdf", "wb") as outputStream:
		output.write(outputStream)	
#68-1 Rev 78
if m>0 and v>0:
	if u>0:
		new_dir = sys.argv[2] + "/68-1-78/"
		new_dir_all = sys.argv[2] + "/all/"
		#if file path has not already been constructed
		if os.path.isdir(new_dir) == False:
			os.makedirs(new_dir)
		output = PdfFileWriter()
		output.addPage(inputpdf.getPage(0))
		str1 = ''.join(filename)
		fullname = str1.split('/')
		names = fullname[2].split('.')
		#writing the file to the original folder, it is supposed to be
		with open(new_dir+names[0]+"."+names[1]+".68-1-78.pdf", "wb") as outputStream:
			output.write(outputStream)
		#writing the file to the all folder	
		with open(new_dir_all+names[0]+"."+names[1]+".68-1-78.pdf", "wb") as outputStream:
			output.write(outputStream)	
	else:
		new_dir = sys.argv[2] + "/68-1-ARCH/"
		new_dir_all = sys.argv[2] + "/all/"
		#if file path has not already been constructed
		if os.path.isdir(new_dir) == False:
			os.makedirs(new_dir)
		output = PdfFileWriter()
		output.addPage(inputpdf.getPage(0))
		str1 = ''.join(filename)
		fullname = str1.split('/')
		names = fullname[2].split('.')
		#writing the file to the original folder, it is supposed to be
		with open(new_dir+names[0]+"."+names[1]+".68-1-ARCH1.pdf", "wb") as outputStream:
			output.write(outputStream)
		#writing the file to the all folder	
		with open(new_dir_all+names[0]+"."+names[1]+".68-1-ARCH1.pdf", "wb") as outputStream:
			output.write(outputStream)	

#68-1 Rev 74
if m>0 and s>0:
	new_dir = sys.argv[2] + "/68-1-74/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".68-1-74.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder	
	with open(new_dir_all+names[0]+"."+names[1]+".68-1-74.pdf", "wb") as outputStream:
		output.write(outputStream)	

#savana river archeological project
if q>1 and p>0:
	new_dir = sys.argv[2] + "/srap/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".srap.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder	
	with open(new_dir_all+names[0]+"."+names[1]+".srap.pdf", "wb") as outputStream:
		output.write(outputStream)	
#highway archeology site form
if (q>1 and o>0) or (n>0):
	new_dir = sys.argv[2] + "/hasf/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".hasf.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder	
	with open(new_dir_all+names[0]+"."+names[1]+".hasf.pdf", "wb") as outputStream:
		output.write(outputStream)	

if w>1:
	new_dir = sys.argv[2] + "/russell/"
	new_dir_all = sys.argv[2] + "/all/"
	#if file path has not already been constructed
	if os.path.isdir(new_dir) == False:
		os.makedirs(new_dir)
	output = PdfFileWriter()
	output.addPage(inputpdf.getPage(0))
	str1 = ''.join(filename)
	fullname = str1.split('/')
	names = fullname[2].split('.')
	#writing the file to the original folder, it is supposed to be
	with open(new_dir+names[0]+"."+names[1]+".russell.pdf", "wb") as outputStream:
		output.write(outputStream)
	#writing the file to the all folder	
	with open(new_dir_all+names[0]+"."+names[1]+".russell.pdf", "wb") as outputStream:
		output.write(outputStream)	

