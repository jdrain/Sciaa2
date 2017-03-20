clear;
clc;
img = imread('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages6.png');
complement_img = imcomplement(img);
se = strel('rectangle',[1,1]);
BW2 = imdilate(complement_img,se);
imtool(complement_img);
imtool(BW2);


verticalProfile1 = sum(complement_img,1);


sum =0;
%for i=1:length(verticalProfile1)
 %   sum = sum + (meanvalue-verticalProfile1(1))^2;
%end    

%subplot(2, 3, 1);
plot(verticalProfile1);
grid on;
title('Vertical Profile Modified abc', 'FontSize', 20, 'Interpreter', 'None');




