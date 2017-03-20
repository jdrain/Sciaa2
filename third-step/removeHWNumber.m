%extreme right upper corner of the image is made white. Generally this area
%contains the handwritten page number.
%gray_img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0001.1985-1.Revisit.2.pdf.tiff.png');
function []=removeHWNumber(arg1) 
    subfolder_names=dir(arg1);
    for iterate=3:length(subfolder_names)
        folder_path = strcat(arg1,subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);
        display(folder_path);
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            display(filename);
            gray_img = imread(filename);
            %complement_img = gray_img > 210;

            %imtool(img);

            img = imcomplement(gray_img);

            [rows_img,columns_img] = size(img);

            start_columns = columns_img - 480;

            for k=1:300
                for j=start_columns:columns_img
                    img(k,j)=0;
                end
            end

            img = imcomplement(img);
            imwrite(img,filename);
        end
    end
    display('successfully removed top right portion of the image');
end    