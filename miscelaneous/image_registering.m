% srcFiles = dir('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\68-1\*.png');  % the folder in which ur images exists
% 
% for ff = 1 : length(srcFiles)
%         c=1;
%         filename = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\68-1\',srcFiles(ff).name);
% 
%         %grayImage1 = imread('C:\Users\akhil\Documents\MATLAB\Origianl Images\38AL0202_1985-1_Revisit_1.pdf.tiff.png');
%         binaryImage1 = imread(filename);
%         name = strsplit(filename,'\');
%         last = length(name);
%         %this number also needs to be changed based on the file path
%         folder_name=strsplit((name{last}),'pdf');
%         mkdir('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\',folder_name{1});
% 
%         
%         [rows1, columns1, numberOfColorBands1] = size(binaryImage1);
%         if numberOfColorBands1 > 1
%             % It's not really gray scale like we expected - it's color.
%             % Convert it to gray scale by taking only the green channel.
%              % Take green channel.
%         end
%         
%         binaryImage1 = binaryImage1 > 210;
% 
%         
%         % _summing the image horizontally_
%         verticalProfile1 = sum(binaryImage1, 2);
%         %top 15 rows of the files are made white, otherwise some times the number of toplines and bottomlines are size 
%         %is generating differently, to solve that the top rows are made
%         %white
%         for v = 1:680
%             if(verticalProfile1(v)~= max(verticalProfile1))
%                 verticalProfile1(v)=max(verticalProfile1);
%             end
%         end
%         %%bottom 20 rows of the files are made white, otherwise some times the number of toplines and bottomlines are size 
%         %is generating differently, to solve that the bottom rows are made
%         %white
%         for v=(length(verticalProfile1)-20): length(verticalProfile1)
%             if(verticalProfile1(v)~= max(verticalProfile1))
%                 verticalProfile1(v)=max(verticalProfile1);
%             end
%         end    
% end


srcFiles = dir('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\68-1\*.png');  % the folder in which ur images exists
 a(length(srcFiles),2) = 0;
 b(length(srcFiles),2) = 0;
 for ff = 1 : length(srcFiles)
         filename = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\68-1\',srcFiles(ff).name);
         %grayImage1 = imread('C:\Users\akhil\Documents\MATLAB\Origianl Images\38AL0202_1985-1_Revisit_1.pdf.tiff.png');
         binaryImage1 = imread(filename);
         binaryImage1 = binaryImage1 > 210;
         [r,c] = size(binaryImage1);
         
         %a(ff,1) = r;
         %a(ff,2) = c;
         
         bg = imcrop(binaryImage1,[100 680 c-180 r-780]);
        [r,c] = size(bg);
        b(ff,1) = r;
         b(ff,2) = c;
        imwrite(bg,filename);     
             
        
             
         



 end
imtool('C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\68-1\38AL0034_68-1-1_Revisit_1a.pdf.tiff.png');