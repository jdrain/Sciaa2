import textProcessing.parser as parser
import textProcessing.processData as processData
import sys, os
from textProcessing import processData

"""
Call this program in the form:
    python main.py <input directory> <output csv>

TODO:
    -add function to get the type of form
"""

#input dir and output path
if len(sys.argv) != 3:
    print("Incorrect number of arguments. Please use the form:"
    " python main.py <input directory> <output csv>")

else:
    #setting I/O vars
    dir_path=sys.argv[1]
    dbf_csv_path=sys.argv[2]

    #get data from json files
    keys=processData.processJSON("./textProcessing/JSONdata/explicit_keys2.json")
    encoding_keys=processData.processJSON("./textProcessing/JSONdata/Encodings.json")
    db_field_coordinates=processData.getDatabaseFieldCoordinates(dbf_csv_path,"./textProcessing/JSONdata/DatabaseFieldCoordinates.json")
    date_conversions=processData.processJSON("./textProcessing/JSONdata/DateConversion.json")

    #since the db coordinates are sometimes inconsistent, we can just
    #mine the data from the csv here

    overall=[]
    for fpath in os.listdir(dir_path):

        #parse filepath to get the form type
        split_fp = fpath.split(".")
        if (len(split_fp) != 2):
            print(
            "Invalid filename. should be of the form: <site"
            +" id>.<form type>"
            )
            print(fpath)
	else:
		form_type = fpath.split(".")[1]
		if form_type not in keys.keys():
		    form_type="68-85"

		fileList=parser.read_file_simple(dir_path+"/"+fpath)
		csvOut=processData.readCSV(dbf_csv_path)

		print("\nsource file: "+fpath+"\n")

		#parse
		print("\nparser is removing underlines: \n")
		fileList=parser.remove_underlines(fileList)

		print("\nparser is removing newline nums: \n")
		fileList=parser.remove_newline_nums(fileList)

		print("\nparser is choosing best matches: \n")
		parsed=parser.filter_potential_data(keys[form_type],fileList)

                if parsed == []:
                    #no need to write nothing to a file
                    print("Nothing here...")

                else:
		    #print results
		    print("\nparsed: \n")
		    for i in parsed:
		        print(i)

		    extracted=parser.extract_data(fileList,parsed,keys[form_type])

		    print("\nextracted: \n")
		    for i in extracted:
		        print(i)

		    formatted=parser.database_format(extracted,keys[form_type],encoding_keys,date_conversions)

		    print("\nformatted: \n")
		    for i in formatted:
		        print(i)

		    #compress and write to file
		    for i in formatted:
		        overall.append(i)

		    #writing to the dbf csv
		    print("\nwriting to dbf file:")
		    processData.write_to_dbf(fpath,formatted,db_field_coordinates,csvOut,dbf_csv_path)
