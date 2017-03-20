from pyPdf import PdfFileWriter, PdfFileReader
import sys
import os
inputpdf = PdfFileReader(open(sys.argv[1], "rb"))

for i in xrange(inputpdf.numPages):
    print("Writing: "+str(sys.argv[1]))
    output = PdfFileWriter()
    output.addPage(inputpdf.getPage(i))
    filename = sys.argv[1].split('.')
    #if file path has not already been constructed
    if os.path.isdir("IndividualFiles/") == False:
        os.makedirs("IndividualFiles/")
    with open("IndividualFiles/"+filename[0]+".page-%s.pdf" % i, "wb") as outputStream:
        output.write(outputStream)
