clc;
 clear;
 close all;

X = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0009_68-1-2_Revisit_1b.pdf.tiff.png');



X = logical(X);
Dist=bwdist(X);


