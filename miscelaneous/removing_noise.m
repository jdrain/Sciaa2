%it will work, but it will remove the small portions of the characters.
%Finally it will reduce the whole output of the image, which it reduces the accuracy.
img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0129_68-1-2_Revisit_1.pdf.tiff.png');
img = imcomplement(img);
imtool(img);
SE = strel('rectangle',[5,5]);
%SE = strel('disk',2);
closeBW = imclose(img,SE);
openBW=imopen(img,SE);
imtool(openBW);
img = imcomplement(openBW);
imwrite(img,'C:\Users\akhil\Documents\MATLAB\Allfiles\temp\abc.png');