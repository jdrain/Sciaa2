% removeHeader removes the top portion of the image, it basically make
% sures that all the noise present at the top is cleaned.

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
            filename = strcat(folder_path,srcFiles(i).name);
            img = imread(filename);
            img = imcomplement(img);
            [rows,columns] = size(img);
            if(rows<(mean_array-300))
                small_file_path=strcat(arg1,'Small_Files\');
                new_path = strcat(small_file_path,srcFiles(i).name);
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


