Step 1:
removeHWNumber.m 
	: It removes the handwritten revisit number written at the extreme top right corner of the image. It takes one argument, pass the input path folder to, it modifies the images and replaces it in the same folder.

Running: removeHWNumber('C:\Users\akhil\Documents\MATLAB\November\Allendale\')

Step 2:
removeHeader.m
	: It removes the top portion of the image i.e it makes it complete white, until it finds some significant text. It takes one argument, pass the input path folder to, it modifies the images and replaces it in the same folder.

Running: removeHeader('C:\Users\akhil\Documents\MATLAB\November\Original_Images\')
 
Step 3:
LineExtraction.m 
	: Extracts individual lines from the given site form. Takes two arguments, first is the input folder path where original files are present and second is the folder path where extracted individual lines are outputed to.

 Running: LineExtraction('C:\Users\akhil\Documents\MATLAB\November\Aiken\','C:\Users\akhil\Documents\MATLAB\November\Aiken_Individual_Lines\')

Step 4:
WordExtraction.m
	:Extracts Individual Words from the Individual lines and places them in the single folder with all the words belonging to the site form. It takes two arguments, first is the input folder path where the individual lines are present and second is the folder path were extracted words are needs to outputed to.

 Running: WordExtraction('C:\Users\akhil\Documents\MATLAB\November\Allendale_Individual_Lines\','C:\Users\akhil\Documents\MATLAB\November\Allendale_Individual_Words\')

Step 5:
RemovingWhiteSpaceAtWordBorder.m
	: It removes the white border which is present around the words and also, it handles one of the false postives of WordExtraction. Some times both are words are extracted and shown as single word in the word extraction, we will remove the space between the borders and club them as single words. These spaces will result in incorrect feature values which in turn reduces the accuracy of the machine learning classification model which we build in the next stage.

 Running: RemovingWhiteSpaceAtWordBorder('C:\Users\akhil\Documents\MATLAB\November\Allendale_Individual_Words\')

Step 6:
GeneratingFeatures.m
	: For each individual word we have segmented, it wil generate feature values, all these feature values are written on to the arff file. For each site form a arff file is created, which contains feature values for all the words of that site form. It takes two arguments, first takes the input path of the words and second takes output path where arff files needs to be created.

 Running: GeneratingFeatures('C:\Users\akhil\Documents\MATLAB\November\Aiken_Individual_Words\','C:\Users\akhil\Documents\MATLAB\November\Aiken_ARFF\');

Step 7:
LargeImageClassification.java
SmallImageClassification.java
	: We have created 2 models, one for handling Large images (79,1985,78 site forms, typically which has more words) and Small images (68,russel, srap etc , typically which has less number of words). These programs will intially predict which word is printed and also their accuracy percentage and which is handwritten and also their accuracy percentage. Once it predicts all the words in a site form image, we calculate number of total words in the site form image, total number of printed words in an site form image, total number of handwritten words in an site form image, total number of handwritten words with accuracy greater than 90%, total number of handwritten words with accuracy greater than 80%, total number of handwritten words with accuracy greater than 70%, total number of handwritten words with accuracy greater than 60%, total number of handwritten words with accuracy greater than 50%. All these values are written on to a arff files, which is again passed to the second model, which will finally predict if an site form image is printed or handwritten. Finally based on this prediction we seperate the orignal cleaned files into handwritten and printed.

	It takes four command line arguemnts. arg1 takes input path where the arff files are stored. arg2 takes arff file name which will be used for the second model. arg3 takes the input path where the original files are present. arg4 takes the path were seperated files needs to be stored.  

 Running: java SmallImageClassification "C:/Users/akhil/Documents/MATLAB/November/Aiken_ARFF/Small/" "C:/Users/akhil/Documents/MATLAB/November/Aiken_small.arff" "C:/Users/akhil/Documents/MATLAB/November/Aiken/" "C:/Users/akhil/Documents/MATLAB/November/Aiken_Seperated/Small/"

Step 8: 
OtsuBinarization.m
	: This will converts the gray scale images into binary images. It takes two arguments, arg1 takes the input path of the gray scale images and arg2 takes the output path where the binarized images needs to be stored. 

 Running: OtsuBinarization('C:/Users/akhil/Documents/MATLAB/November/Aiken_Seperated/Printed/','C:/Users/akhil/Documents/MATLAB/November/Aiken_Binarized/')
