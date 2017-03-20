%this is the original word extractor, but this code has problems with the
%rectangle values. I am still in the process of finding the threshold
%values.
srcFiles = dir('C:\Users\akhil\Documents\MATLAB\Individual_words\*.png');% the folder in which ur images exists
columns = zeros(length(srcFiles),1);
for i=1 : length(srcFiles)
    filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_words\',srcFiles(i).name);
    img = imread(filename);
    [row,column]=size(img)
    columns(i)=column;
end
mean_columns=mean(columns);

for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_words\',srcFiles(i).name);
    img = imread(filename);
    %image(img);
    %gray = rgb2gray(img);
    %bwimg = im2bw(gray, 0.75);
    if(columns(i,1)>mean_columns)
        workingimg = imcomplement(img);
        se1 = strel('rectangle', [15,30]);
        %se1 = strel('rectangle', [25,50]);
        dilatedimg = imdilate(workingimg, se1);
    
        se2 = strel('disk', 2);
        erodedimg = imerode(dilatedimg, se2);

        ppimg = imfill(erodedimg, 'holes');

        %imgcontour = imcontour(ppimg);
        stats = regionprops(ppimg, 'BoundingBox');
        for object = 1:length(stats)
            subImage = imcrop(img, stats(object).BoundingBox);
        
            filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_words\small\',srcFiles(i).name);
            filename = strcat(filename,int2str(object));
            filename = strcat(filename , '.png');
            subImage = imcomplement(subImage);
            abc_subImage = sum(subImage,1);
            number_of_pixels = sum(abc_subImage,2);
            subImage = imcomplement(subImage);
            
            
            if(number_of_pixels>800)
                imwrite(subImage,filename);
            end    
    end
    end
end
display('word extraction completed succesfully');