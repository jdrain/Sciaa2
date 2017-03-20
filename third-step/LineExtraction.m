%Correct version

function []=LineExtraction(arg1,arg2)
    workspace;  % Make sure the workspace panel is showing.
    format long g;
    format compact;
    tic;
    subfolder_names=dir(arg1);
    for iterate=3:length(subfolder_names)
        folder_path = strcat(arg1,subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        display(folder_path);
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);
        %below function call will make a call to the generating_names function in
        %the generating_names.m file and it will generate file
        default_file_names = generating_line_names();

        for ff = 1 : length(srcFiles)
                c=1;
                filename = strcat(folder_path,srcFiles(ff).name);
                display(filename);
                binaryImage1 = imread(filename);
                name = strsplit(filename,'\');
                last = length(name);
                %this number also needs to be changed based on the file path
                folder_name=strsplit((name{last}),'png');
                output_destination = strcat(arg2,subfolder_names(iterate).name);
                output_destination = strcat(output_destination,'\');
                display(output_destination);
                mkdir(output_destination,folder_name{1});


                [rows1, columns1, numberOfColorBands1] = size(binaryImage1);
                if numberOfColorBands1 > 1
                    % It's not really gray scale like we expected - it's color.
                    % Convert it to gray scale by taking only the green channel.
                     % Take green channel.
                end

                binaryImage1 = binaryImage1 > 210;


                % _summing the image horizontally_
                verticalProfile1 = sum(binaryImage1, 2);
                %top 15 rows of the files are made white, otherwise some times the number of toplines and bottomlines are size 
                %is generating differently, to solve that the top rows are made
                %white
                for v = 1:15
                    if(verticalProfile1(v)~= max(verticalProfile1))
                        verticalProfile1(v)=max(verticalProfile1);
                    end
                end
                %%bottom 20 rows of the files are made white, otherwise some times the number of toplines and bottomlines are size 
                %is generating differently, to solve that the bottom rows are made
                %white
                for v=(length(verticalProfile1)-20): length(verticalProfile1)
                    if(verticalProfile1(v)~= max(verticalProfile1))
                        verticalProfile1(v)=max(verticalProfile1);
                    end
                end    


                thresh = max(verticalProfile1) - mod(max(verticalProfile1),100);
                rowsWithText1 = verticalProfile1 < thresh;


                topLines1 = find(diff(rowsWithText1) == 1);
                bottomLines1 = find(diff(rowsWithText1) == -1);


                    combine_image= struct([]);
                    for k = 1 : length(topLines1)  % _loop for segmenting horizontal lines_
                        topRow1 = topLines1(k);
                        bottomRow1 = bottomLines1(k);

                                thisLine1 = binaryImage1(topRow1:bottomRow1, :);
                                output_destination = strcat(arg2,subfolder_names(iterate).name);
                                output_destination = strcat(output_destination,'\');
                                name=strcat(output_destination,folder_name{1});
                                name = strcat(name,'\line_');
                                filename = strcat(name,default_file_names{k});
                                filename = strcat(filename , '.png');
                                %we are writing only if height of the line is big, all the lines with
                                %the noise are not written with this code.
                                [rows,columns] = size(thisLine1);

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
                                                    imwrite(thisLine1,filename);
                                                    combine_image(c).first = default_file_names{k};
                                                    combine_image(c).second = default_file_names{k+1};
                                                    c=c+1;
                                                end    
                                            end
                                    end 

                                end       

                        horizontalProfile1 = sum(thisLine1, 1);
                        theThreshold1 = 0.8 * abs(topRow1-bottomRow1);
                        columnWithText1 = horizontalProfile1 < theThreshold1;
                        leftCharacter1 = find(diff(columnWithText1) == 1);
                        rightCharacter1 = find(diff(columnWithText1) == -1);
                        if isempty(leftCharacter1) || isempty(rightCharacter1)
                            continue;
                        end

                    end
                    %All the files which are required are already written on to the
                    %folder and files which are need to be combined their
                    %information is stored in the combine_image structures. in the
                    %below code all those files are combined and written to the
                    %folder.
                [rows_combine_image,columns_combine_image] = size(combine_image); 
                for i=1:columns_combine_image
                   %loading the current file 

                           current_file_name = strcat(name,combine_image(i).first);
                           current_file_name = strcat(current_file_name , '.png');
                           cf = imread(current_file_name);
                           %imcomplement is used to inverse the image so that it can be added with
                           %another image withou any problem
                           current_file = imcomplement(cf);
                           [cf_row,cf_column] = size(current_file);
                           %loading the next file 

                           %next_file_name = strcat(name,int2str(combine_image(i,2)));
                           next_file_name = strcat(name,combine_image(i).second);
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
                           %combined_file_name = strcat(name,int2str(combine_image(i,1)));
                           combined_file_name = strcat(name,combine_image(i).first);
                           combined_file_name = strcat(combined_file_name , '.png');
                           imwrite(combined_file,combined_file_name);

                end
             %newly added to the code
                clearvars -except ff srcFiles fontSize default_file_names arg1 arg2 folder_path iterate subfolder_names

        end
    end
    display('Extraction of lines succesfully completed');
end    




         