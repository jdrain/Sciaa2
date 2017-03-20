%For some of the features in the machine learning model there shouldn't be white border along the words.
%So this program will traverse through each word and remove the white
%border around the words. 
function []=RemovingWhiteSpaceAtWordBorder(arg1)
    folder_names=dir(arg1);
    for sft=3:length(folder_names)
        subfolder_path=strcat(arg1,folder_names(sft).name);
        subfolder_path=strcat(subfolder_path,'\');
        subfolder_names=dir(subfolder_path);
        for iterate=3:length(subfolder_names)
                folder_path = strcat(subfolder_path,subfolder_names(iterate).name);
                folder_path = strcat(folder_path,'\');
                all_files = strcat(folder_path,'*.png');
                srcFiles = dir(all_files);
                      % the folder in which ur images exists
                for i = 1 : length(srcFiles)
                    filename = strcat(folder_path,srcFiles(i).name);
                    img = imread(filename);    
                   %img = imread('C:\Users\akhil\Documents\MATLAB\Individual_words\mgood2\lineimages7.png1.png');
                   %imtool(img);
                   [number_row,number_column]=size(img);
                   complement_img = imcomplement(img);
                   columns_sum = sum(complement_img,1);
                   k=1;
                   final_image_columns = 0;
                   for j=1:length(columns_sum)
                      if(columns_sum(1,j)>0)
                          final_image_columns = final_image_columns + 1;
                      end
                   end
                   final_image_after_columns = zeros(number_row,final_image_columns);
                   for j=1:length(columns_sum)
                       if(columns_sum(1,j)>0)
                          final_image_after_columns(:,k)=complement_img(:,j);
                          k=k+1;
                       end

                   end    
                   %imtool(final_image);
                   k=1;
                   final_image_rows = 0;
                   rows_sum = sum(final_image_after_columns,2);
                   for j=1:length(rows_sum)
                      if(rows_sum(j,1)>0)
                          final_image_rows = final_image_rows + 1;
                      end
                   end
                   final_image_after_rows = zeros(final_image_rows,final_image_columns);
                   for j=1:length(rows_sum)
                       if(rows_sum(j,1)>0)
                          final_image_after_rows(k,:)=final_image_after_columns(j,:);
                          k=k+1;
                       end 
                   end
                   %imtool(final_image_after_rows);
                   final_image = imcomplement(final_image_after_rows);
                   imwrite(final_image,filename);

                end
        end     
        display('Removed the white spaces succesfully');
    end     
end    