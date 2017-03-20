%this program works but its implementation is already done in the
%line_extraction file in antother way, instead of writing all(including small black lines) the lines
%we are writing only lines which has some widht and rest of the files
%based on its distance are added to one another.

clear;
clc;
srcFiles = dir('C:\Users\akhil\Documents\MATLAB\Individual_words\small1\*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_words\small1\',srcFiles(i).name);
        %i = imread('C:\Users\akhil\Documents\MATLAB\Individual_words\mgood235\lineimages47.png7.png');
        j = imread(filename);
        complement_img = imcomplement(j);
        img = complement_img > 210;
        %imtool(img);
        [rows,columns]=size(img);
        total = rows * columns;
        abc_subImage = sum(img,1);
        number_of_pixels = sum(abc_subImage,2);
        percent = (number_of_pixels/total);
        if(percent<.90)
            display(percent,'i am not removing it')
            imtool(img);
        end
end