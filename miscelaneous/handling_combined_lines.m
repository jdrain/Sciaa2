clear;
clc;
%We find the mean of the height of all the individual line images for each
%image based on the that we find out if there are any images with greater
%height(contains more than one lines in the images)
subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\');
for iterate=3:length(subfolder_names)
        folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\',subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);  % the folder in which ur images exists
        number_rows = zeros(length(srcFiles));
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            img = imread(filename);
            [rows_img,columns_img] = size(img);
            number_rows(i) = rows_img; 
        end    
        
        mean_value = mean(number_rows);
        
        
end



