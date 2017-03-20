%this version of the line_extraction is not used.

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
tic;
c=1;


%grayImage1 = imread('C:\Users\akhil\Documents\MATLAB\Origianl Images\38AL0202_1985-1_Revisit_1.pdf.tiff.png');
grayImage1 = imread('C:\Users\akhil\Documents\MATLAB\Origianl Images\38AL0002_68-1-1.Revisit.1a.pdf.tiff.png');


%grayImage1 = rgb2gray(grayImage1);
% Get the dimensions of the image.
% numberOfColorBands1 should be = 1.
[rows1, columns1, numberOfColorBands1] = size(grayImage1);
if numberOfColorBands1 > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	 % Take green channel.
end
% Display the original gray scale image.

%imshow(grayImage1, []);
%title('Original Grayscale Image', 'FontSize', 20, 'Interpreter', 'None');
%axis on;

% Set up figure properties:
% Enlarge figure to full screen.
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
%set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
%set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

binaryImage1 = grayImage1 > 210;

%binaryImage1 = imcomplement(binaryImage);
%title('Binary Image', 'FontSize', 20, 'Interpreter', 'None');
%axis on;

% _summing the image horizontally_
verticalProfile1 = sum(binaryImage1, 2);
%trying to make the top 15 rows of the page to be white, this is done to
%avoid the the problem of topLines greater than the bottomlines. It mostly occurs because of some disturbances at the start of the start of the image. 
%solve 
for v = 1:15
    if(verticalProfile1(v)~= max(verticalProfile1))
        verticalProfile1(v)=max(verticalProfile1);
    end
end

%for the difference of the adjacent values of the verticalProfile we are
%trying to cluster them into 2 groups and for the cluster with difference of  maximum
%vertical profile values we want to calcuate the average of it.



%subplot(2, 3, 3);
%plot_img=plot(verticalProfile1, 'b-');
%imwrite(plot_img,'C:\Users\akhil\Documents\MATLAB\Origianl Images\plot.png');
%grid on;
%title('Vertical Profile Modified', 'FontSize', 20, 'Interpreter', 'None');

% _create logical vector of what lines have text and which do not based on
%threshold_
maxValue = max(verticalProfile1);
modeValue = mod(max(verticalProfile1),100);
thresh = max(verticalProfile1) - mod(max(verticalProfile1),100);
rowsWithText1 = verticalProfile1 < thresh;

% _finding top and bottom lins_
%topLines1 = find(diff(rowsWithText1) == 1);
%bottomLines1 = find(diff(rowsWithText1) == -1);

topLines1 = find(diff(rowsWithText1) == 1);
bottomLines1 = find(diff(rowsWithText1) == -1);
%this si for the K means clustering 
%if(length(topLines1)==length(bottomLines1))
 %   difference = (bottomLines1-topLines1);
%end

%kresult = kmeans(difference,3);
%group1 = difference(find(kresult==1));
%group2 = difference(find(kresult==2));
%group3 = difference(find(kresult==3));

%if(length(topLines1)<length(bottomLines1))
 %          j=((length(bottomLines1)-length(topLines1))+1);
  %        for k = 1 : length(topLines1)  % _loop for segmenting horizontal lines_
   %             topRow1 = topLines1(k);
    %%            bottomRow1 = bottomLines1(j);
      %          thisLine1 = binaryImage1(topRow1:bottomRow1, :);
%
 %               %subplot(2, 3, 4);
  %              %imshow(thisLine1, []);
   %             filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages',int2str(k));
    %            filename = strcat(filename , '.png');
     %           %we are writing only if height of the line is big, all the lines with
      %          %the noise are not written with this code.
       %%        imwrite(thisLine1,filename);
         %       if(rows > 20)
          %          display('writing file');
                    %imwrite(thisLine1,filename);
           %     end
                %axis on;
                %caption = sprintf('Line %d of the text', k);
                %title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

                % _summing the segmented image vertically_
            %    horizontalProfile1 = sum(thisLine1, 1);
                %subplot(2, 3, 5);
                %plot(horizontalProfile1, 'b-');
                %grid on;
                %caption = sprintf('Horizontal Profile of Line %d of the text', k);
                %title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

             %   theThreshold1 = 0.8 * abs(topRow1-bottomRow1);
              %  columnWithText1 = horizontalProfile1 < theThreshold1;
               % leftCharacter1 = find(diff(columnWithText1) == 1);
                %rightCharacter1 = find(diff(columnWithText1) == -1);
                %if isempty(leftCharacter1) || isempty(rightCharacter1)
                 %   continue;
                %end

                %promptMessage = sprintf('This is the image between rows1 %d and %d, inclusive.\nDo you want to find letters within this line,\nor Cancel to abort processing?', topRow1, bottomRow1);
                %titleBarCaption = 'Continue?';
                %button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
                %if strcmpi(button, 'Cancel')
                %    return;
                %end

                %subplot(2, 3, 6);
                %j=j+1;
        %end

%elseif(length(topLines1)>length(bottomLines1))
        %i=((length(topLines1)-length(bottomLines1))+1);
        %for k = 1 : length(topLines1)  % _loop for segmenting horizontal lines_
           % topRow1 = topLines1(i);
           % bottomRow1 = bottomLines1(k);
           % thisLine1 = binaryImage1(topRow1:bottomRow1, :);

            %subplot(2, 3, 4);
            %imshow(thisLine1, []);
           % filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages',int2str(k));
           % filename = strcat(filename , '.png');
            %we are writing only if height of the line is big, all the lines with
            %the noise are not written with this code.
           % [rows,columns] = size(thisLine1);
           % imwrite(thisLine1,filename);
           % if(rows > 20)
           %     display('writing file');
                %imwrite(thisLine1,filename);
          %  end
            %axis on;
            %caption = sprintf('Line %d of the text', k);
            %title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

            % _summing the segmented image vertically_
          %  horizontalProfile1 = sum(thisLine1, 1);
            %subplot(2, 3, 5);
            %plot(horizontalProfile1, 'b-');
            %grid on;
            %caption = sprintf('Horizontal Profile of Line %d of the text', k);
            %title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

           % theThreshold1 = 0.8 * abs(topRow1-bottomRow1);
          %  columnWithText1 = horizontalProfile1 < theThreshold1;
         %   leftCharacter1 = find(diff(columnWithText1) == 1);
            %rightCharacter1 = find(diff(columnWithText1) == -1);
           % if isempty(leftCharacter1) || isempty(rightCharacter1)
          %      continue;
         %   end

        %    promptMessage = sprintf('This is the image between rows1 %d and %d, inclusive.\nDo you want to find letters within this line,\nor Cancel to abort processing?', topRow1, bottomRow1);
       %     titleBarCaption = 'Continue?';
      %      button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
     %       if strcmpi(button, 'Cancel')
    %            return;
   %         end

            %subplot(2, 3, 6);
  %          i=i+1;
 %       end

%else
    %combine_image(length(topLines1),2) = 0;
    combine_image(:,2) = 0;
    for k = 1 : length(topLines1)  % _loop for segmenting horizontal lines_
        topRow1 = topLines1(k);
        bottomRow1 = bottomLines1(k);
        thisLine1 = binaryImage1(topRow1:bottomRow1, :);

        %subplot(2, 3, 4);
        %imshow(thisLine1, []);
        filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages',int2str(k));
        filename = strcat(filename , '.png');
        %we are writing only if height of the line is big, all the lines with
        %the noise are not written with this code.
        [rows,columns] = size(thisLine1);
        
        %to print all the lines which are extracted
        %allfilename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\all\lineimages',int2str(k));
        %allfilename = strcat(allfilename , '.png');
        %imwrite(thisLine1,allfilename);
        
        if(rows > 20)
            %display('writing file');
            imwrite(thisLine1,filename);
        else
            if(k~=length(topLines1))
                    %bt = (bottomLines1(k)-topLines1(k+1));
                    bt = (topLines1(k+1)- bottomLines1(k));
                    if(bt<10)
                        size_of_next_image = (bottomLines1(k+1)-topLines1(k+1));
                        if(size_of_next_image>20)
                            %wirting the image only if the next image is
                            %bigger image and the current image can be
                            %attached to it
                            imwrite(thisLine1,filename);
                            combine_image(c,1) = k;
                            combine_image(c,2) = k+1;
                            c=c+1;
                        end    
                    end
            end     
        end       
                
        %axis on;
        %caption = sprintf('Line %d of the text', k);
        %title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

        % _summing the segmented image vertically_
        horizontalProfile1 = sum(thisLine1, 1);
        %subplot(2, 3, 5);
        %plot(horizontalProfile1, 'b-');
        %grid on;
        %caption = sprintf('Horizontal Profile of Line %d of the text', k);
        %title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

        theThreshold1 = 0.8 * abs(topRow1-bottomRow1);
        columnWithText1 = horizontalProfile1 < theThreshold1;
        leftCharacter1 = find(diff(columnWithText1) == 1);
        rightCharacter1 = find(diff(columnWithText1) == -1);
        if isempty(leftCharacter1) || isempty(rightCharacter1)
            continue;
        end

        %promptMessage = sprintf('This is the image between rows1 %d and %d, inclusive.\nDo you want to find letters within this line,\nor Cancel to abort processing?', topRow1, bottomRow1);
        %titleBarCaption = 'Continue?';
        %button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
        %if strcmpi(button, 'Cancel')
         %   return;
        %end

        %subplot(2, 3, 6);
    end
%end
% _looping for extracting characters in the image_

% joinig the images based on the number of rows, all the small sized images
% are joined with the big images, considering that it may be accedentally
% craved out of it.

for i=1:length(combine_image)
   %loading the current file 
   current_file_name = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages',int2str(combine_image(i,1)));
   current_file_name = strcat(current_file_name , '.png');
   cf = imread(current_file_name);
   %imcomplement is used to inverse the image so that it can be added with
   %another image withou any problem
   current_file = imcomplement(cf);
   [cf_row,cf_column] = size(current_file);
   %loading the next file 
   next_file_name = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages',int2str(combine_image(i,2)));
   next_file_name = strcat(next_file_name , '.png');
   nf = imread(next_file_name);
   %imcomplement is used to inverse the image so that it can be added with
   %another image withou any problem
   next_file=imcomplement(nf);
   [nf_row,nf_column] = size(next_file);
   
   %joining the two image
   combined_file = current_file;
   for j=1:nf_row
       combined_file(cf_row+j,:) = next_file(j,:);
   end
   combined_file=imcomplement(combined_file);
   %deleting the small sized images because it's already been added with
   %the other image
   delete(next_file_name);
   combined_file_name = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages',int2str(combine_image(i,1)));
   combined_file_name = strcat(combined_file_name , '.png');
   imwrite(combined_file,combined_file_name);
end

display('Extraction of lines succesfully completed');