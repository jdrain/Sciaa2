clear;
clc;
%adding the two images and slat and pepper noise removal program

img1 = imread('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages15.png');
img2= imread('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages16.png');
%img = imfuse(img1,img2);
[rows1 columns1]=size(img1);
[rows2 columns2]=size(img2);
k=1;
for i=rows1+1:rows1+rows2
    for j=1:columns1
        img1(i,j)=img2(k,j);
    end
    k=k+1;
end
    
imtool(img1);
%I = double(img);
%J=imnoise(I,'salt & pepper',0.06);
%imtool(J);
%Kaverage = filter2(fspecial('average',3),J)/255;
%imtool(Kaverage);
%Kmedian = medfilt2(J);
%imtool(Kmedian);