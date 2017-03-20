%imtool('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\68-1\38AL0009_68-1-1_Revisit_1a.pdf.tiff.png');
%this program is used for adding white border around the line images.

subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\');

for iterate=3:length(subfolder_names)
        folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\',subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);  % the folder in which ur images exists

        %srcFiles = dir('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\38AL0003_68-1-1_Revisit_1a\*.png');  % the folder in which ur images exists

        for ff = 1 : length(srcFiles)
            c=1;
            filename = strcat(folder_path,srcFiles(ff).name);
            %display(filename);
            img =imread(filename);
            img = imcomplement(img);
            img = padarray(img,[20 20]);
            img = imcomplement(img);
            imwrite(img,filename);
        end
end        
