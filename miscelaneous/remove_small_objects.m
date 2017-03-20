%haven't done fully, so this file is just proof of concept.

img = imread('C:\Users\akhil\Documents\SCIAA\noise_reducing_input-files\38AL0001.68-1-1.Revisit.1a.pdf.tiff.png');
r_img = bwareaopen(img,5);
imwrite(r_img,'C:\Users\akhil\Documents\SCIAA\noise_reducing_input-files\r_img.png');