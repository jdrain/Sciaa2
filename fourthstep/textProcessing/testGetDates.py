from textProcessing import recognize_dates
from textProcessing import parser
import sys

#make my life easier
get_date = recognize_dates.get_date
check_date_format = recognize_dates.check_date_format
read_file_simple = parser.read_file_simple

#filepath
fpath = sys.argv[1]
json_path = "textProcessing/DateConversion.json"

#read file into list
file_ls = read_file_simple(fpath)

#get date
date = get_date(file_ls,json_path)
d_format = check_date_format(date)

#output
print("\nFile: "+str(fpath))
print("Extracted date: "+str(date))
print("Good format: "+str(d_format))
