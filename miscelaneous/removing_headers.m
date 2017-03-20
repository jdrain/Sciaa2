clear;
clc;

%img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0129_68-1-2_Revisit_1.pdf.tiff.png');
%img = imcomplement(img);
function []=removeHeader(arg1) 
    subfolder_names=dir(arg1);
    for iterate=3:length(subfolder_names)
        folder_path = strcat(arg1,subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);
        array = zeros(length(srcFiles),1);
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            display(filename);
            img = imread(filename);
            [number_rows,number_columns] = size(img);
            array(i)=number_rows;
        end   
        mean_array = mean(array);
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path',srcFiles(i).name);
            img = imread(filename);
            img = imcomplement(img);
            [rows,columns] = size(img);
            if(rows<(mean_array-300))
                new_path = strcat('C:\Users\akhil\Documents\MATLAB\November\Original_Images\Small_Files\',srcFiles(i).name);
                imwrite(img,new_path);
                delete(filename);
            else
                verticalProfile = sum(img, 2);
                maximum_vertical_profile = max(verticalProfile);
                for j=1:length(verticalProfile)
                    %it find outs the first line in the image from the top and
                    %befor that all the border is made white.
                    if(verticalProfile(j) > (maximum_vertical_profile * 0.20))
                       img(1:j,:)=0;
                       img = imcomplement(img);
                       imwrite(img,filename);
                       break;
                    end    
                end    
            
            
            end    
        end
    end
end    

%We find the mean of the height of all the individual line images for each
%image based on the that we find out if there are any images with greater
%height(contains more than one lines in the images)
% subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Files\');
% for iterate=3:length(subfolder_names)
%         folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Files\',subfolder_names(iterate).name);
%         folder_path = strcat(folder_path,'\');
%         all_files = strcat(folder_path,'*.png');
%         srcFiles = dir(all_files);  % the folder in which ur images exists
%         number_rows = zeros(length(srcFiles));
%         for i = 1 : length(srcFiles)
%             filename = strcat(folder_path,srcFiles(i).name);
%             img = imread(filename);
%             [rows_img,columns_img] = size(img);
%             number_rows(i) = rows_img; 
%         end    
%         
% 
%         
% end
% 
