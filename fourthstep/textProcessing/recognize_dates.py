from fuzzywuzzy import fuzz
import re

date_chars=['0','1','2','3','4','5','6','7','8','9','/','.','-',' ']

"""
Function: take in a file (slit over white space) and then extract a date
from it
"""
def get_date(info):
    date=clean_date(info)
    date_ls=date.split(" ")
    if len(date_ls) != 3:
        return ["RECORDEDDA",""]
    else:
        date="/".join(date_ls[0:2])+date_ls[2]
        return ["RECORDEDDA",date]

"""
function: take in a string (date) and clean it up
"""
def clean_date(date):
    if date != "NULL":
        for c in date:
            if c not in date_chars:
                date=date.replace(c,"")
    return date

"""
function: check the format of a string(date)
"""
def check_date_format(date):
    nums=date_chars[0:len(date_chars)-1]
    correct_format = True

    #first split over forward slash
    date_ls=date.split("/")

    #if len is not 3 the format is wrong
    if len(date_ls) != 3:
        correct_format = False

    #if date_ls has chars others than nums the format is wrong
    if correct_format == True:
        for i in date_ls:
            for j in i:
                if j not in nums:
                    correct_format = False
                    break

    if correct_format == True:
        #either MM/DD/YY or MM/DD/YYYY
        l = len(date_ls[2])
        if l != 2 and l != 4:
            correct_format = False

    return correct_format
