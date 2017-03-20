    
    %this code is used for word extraction from the lines. It is the
    %modified version of the original code, we just modified different rectangle values and we can take single lines and by experiments 
    %we can find out the threshold value for the rectangle.

    img = imread('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages156.png');
    %image(img);
    %gray = rgb2gray(img);
    %bwimg = im2bw(gray, 0.75);
    workingimg = imcomplement(img);
    %se1 = strel('rectangle', [18,35]);
    se1 = strel('rectangle', [25,50]);
    dilatedimg = imdilate(workingimg, se1);
    
    se2 = strel('disk', 2);
    erodedimg = imerode(dilatedimg, se2);

    ppimg = imfill(erodedimg, 'holes');

    %imgcontour = imcontour(ppimg);
    stats = regionprops(ppimg, 'BoundingBox');
    for object = 1:length(stats)
        subImage = imcrop(img, stats(object).BoundingBox);
        
        filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_words\','words');
        filename = strcat(filename,int2str(object));
        filename = strcat(filename , '.png');
        imwrite(subImage,filename);
    end