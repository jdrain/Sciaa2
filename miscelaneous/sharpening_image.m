clear;
clc;

img1 = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\smaller_output_original_files\printed\38AL0001.68-1-1.Revisit.1a.pdf.tiff.png');
img = imsharpen(img1);
imwrite(img,'C:\Users\akhil\Documents\MATLAB\Allfiles\smaller_output_original_files\printed\11_68.png');