%this is just a proof of concept of removig headers actual code is in
%removing_headers.m

%img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0129_68-1-2_Revisit_1.pdf.tiff.png');
%img = imcomplement(img);
%verticalProfile = sum(img, 2);
%plot_img=plot(verticalProfile, 'b-');
clear;
clc;


subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\temp\Individual_Files\');
for iterate=3:length(subfolder_names)
        folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\temp\Individual_Files\',subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);  % the folder in which ur images exists
        number_rows = zeros(length(srcFiles),1);
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            img = imread(filename);
            [rows_img,columns_img] = size(img);
            number_rows(i) = rows_img; 
        end    
        
        final_mean = mean(number_rows);
        standard_deviation = std(number_rows,1);
        last = 3;
        for j=1:last
            filename = strcat(folder_path,srcFiles(j).name);
            img = imread(filename);
            [r,c] = size(img);
            if(r < (final_mean + standard_deviation))
                delete(filename);
            else
                
                if(r>(3*final_mean))
                    delete(filename);
                    break;
                elseif(r>(2*final_mean))
                    if(j==1)
                        delete(filename);
                        last = 2;
                    elseif(j==2)
                        delete(filename);
                        break;
                    else
                        delete(filename);
                        break;
                    end    
                else
                       if(j==1)
                        delete(filename);
                        last = 2;
                    elseif(j==2)
                        delete(filename);
                        break;
                    else
                        delete(filename);
                        break;
                    end
                end    
            end    
        end    
        
end
