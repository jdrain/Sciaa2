%this is the original word extractor, but this code has problems with the
%rectangle values. I am still in the process of finding the threshold
%values.
function []=WordExtraction(arg1,arg2)
    folder_names=dir(arg1);
    default_word_names = generating_word_names();
    for sft=3:length(folder_names)
            subfolder_path=strcat(arg1,folder_names(sft).name);
            subfolder_path=strcat(subfolder_path,'\');
            subfolder_names=dir(subfolder_path);
            for iterate=3:length(subfolder_names)
                    folder_path = strcat(subfolder_path,subfolder_names(iterate).name);
                    folder_path = strcat(folder_path,'\');
                    all_files = strcat(folder_path,'*.png');
                    srcFiles = dir(all_files);  % the folder in which ur images exists
                    outputpath = strcat(arg2,folder_names(sft).name);
                    outputpath = strcat(outputpath,'\');
                    mkdir(outputpath,subfolder_names(iterate).name);
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

                            path = strcat(outputpath,subfolder_names(iterate).name);
                            display(path);
                            try
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
                            catch ME
                                if(strcmp(ME.identifier,'MATLAB:Index exceeds matrix dimensions'))
                                    display('problem with the image');
                                end    
                                
                            end    
                        end
                    end
            end
    end        
    display('word extraction completed succesfully');
end    