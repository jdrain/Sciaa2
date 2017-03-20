subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\output_original_files\printed\*.png');
for iterate=1:length(subfolder_names)
        image_name = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\output_original_files\printed\',subfolder_names(iterate).name);
        img = imread(image_name);
        
        [rows,columns] = size(img);
        imtool(img);
        count1=0;
        count2=0;
        for i=1:rows
           for j=1:columns

              if img(i,j) == 0
                 count1 = count1 + 1;
              elseif img(i,j) == 255
                 count2 = count2 + 1;
              end   
           end 
        end   

        total = rows * columns;
        sum = count1 + count2;

        if total == sum
            display('image has either 0 or 255 values');
        else
            display('image has values between 0-255 for each pixels');
            
            img2 = img > 220;
            imtool(img2);
            img2_name = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\output_original_files\modified_printed\',subfolder_names(iterate).name);
            imwrite(img2,img2_name);
        end    
end