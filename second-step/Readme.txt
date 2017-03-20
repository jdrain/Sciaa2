First command will convert the pdf files into tiff. Image magick library is used for conversion. It will iterate through all the different site form folder and convert the individual file in the folder and then remove the individual pdf file. 

Covert the images(some colors) into gray scale images using convertgray of leptonica.  Download the leptonica library and replace the ./prog/converttogray.c with our converttogray.c file. Run the make file and use the executable to convert the images. Similar for the next step aswell.
command: for i in */; do for j in $i/*.pdf; do ./converttogray $j $j; done; done;

Remove underlines from the image using lineremoval of leptonica.
command: for i in *; do for j in $i/*.tiff; do ./lineremoval $j; done; done;
