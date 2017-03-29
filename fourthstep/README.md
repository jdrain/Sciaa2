# SCIAA_spellcheck
This repository holds files for a parser 

![alt-text](https://travis-ci.org/jdrain/SCIAA_spellcheck.svg?branch=master)

1. Improvements Needed
  + We need to change main.py so that it actually considers different
    form types and 1985 is not just hard coded.
2. Main 
  + Main.py will run a batch process to get data from individual text
    files and write to a singular CSV.
3. Customization
  + Should one want to write their own main:
  + spellcheck.py holds methods to run a spellchecker on a file
  + parser.py parses a file to grab pertinent info
  + checkAndParse.py implements these to process a textfile from I to O.
  + other files are scripts to test these methods
4. Other
  + a few .json files are included; these hold information that the
    parser needs to decide which lines to pull and which to ignore,
    how to process the data into its final format, and how to insert
    the data into the spreadsheet.
