%this is the original word extractor, but this code has problems with the
%rectangle values. I am still in the process of finding the threshold
%values.
subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Files\');
default_word_names = generating_word_names();
for iterate=3:length(subfolder_names)
        folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Files\',subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);  % the folder in which ur images exists
        mkdir('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words\',subfolder_names(iterate).name);
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            img = imread(filename);
            %image(img);
            %gray = rgb2gray(img);
            %bwimg = im2bw(gray, 0.75);
            workingimg = imcomplement(img);
            %se1 = strel('rectangle', [6,12]);
            se1 = strel('rectangle', [25,50]);
            dilatedimg = imdilate(workingimg, se1);

            se2 = strel('disk', 2);
            erodedimg = imerode(dilatedimg, se2);

            ppimg = imfill(erodedimg, 'holes');

            %imgcontour = imcontour(ppimg);
            stats = regionprops(ppimg, 'BoundingBox');
            for object = 1:length(stats)
                subImage = imcrop(img, stats(object).BoundingBox);
                
                path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words\',subfolder_names(iterate).name);
                path = strcat(path,'\');
                linename_split = strsplit(srcFiles(i).name,'.');
                filename = strcat(path,linename_split{1});
                filename = strcat(filename,'_');
                filename = strcat(filename,default_word_names{object});
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