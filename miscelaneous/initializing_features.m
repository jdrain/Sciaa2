
clear;
clc;

ph_file_id = fopen('C:\Users\akhil\Documents\WEKA\phtrainingfile.arff','at');
file_id = fopen('C:\Users\akhil\Documents\WEKA\onefullfile.arff','at');
subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words\');
vpv(:,1)=(0);
pd(:,1)=(0);
mhpd(:,1)=(0);
mve(:,1)=(0);
for iterate=3:length(subfolder_names)
        folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words\',subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);
        fprintf(file_id,'\n');
        fprintf(file_id,'\n');
        fprintf(file_id,'\n');
        fprintf(file_id,'\n');
        fprintf(file_id,'It is new file');
        fprintf(file_id,'\n');
        
        total_number_words = length(srcFiles);
        number_printed_words = 0;
        number_handwritten_words = 0;
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            vpv(i) = vertical_projection_variance(filename);
            a=vpv(i);
            fprintf(file_id,'%.2f',vpv(i));
            fprintf(file_id,',');
            mhpd(i) = major_horizontal_projection_difference(filename);
            fprintf(file_id,'%d',mhpd(i));
            fprintf(file_id,',');
            mve(i) = vertical_edges(filename);
            c=mve(i);
            fprintf(file_id,'%.2f',mve(i));
            fprintf(file_id,',');
            pd(i) = pixel_distribution(filename);
            b=pd(i);
            fprintf(file_id,'%.2f',pd(i));
            fprintf(file_id,',');
            %fprintf(file_id,'Handwritten');


        %     imtool(filename);
        %     display(i);
        %     prompt = 'Is the image a Printed or Handwritten';
        %     class = input(prompt,'s');
        %     fprintf(file_id,'%s',class);
        %   
            if(vpv(i)<=8285754.52)

                if(mhpd <= 6885)

                    if(vpv(i)<=7271931.09)
                        fprintf(file_id,'Handwritten');
                        class = 'Handwritten';
                    else
                        fprintf(file_id,'Printed');
                        class = 'Printed';
                    end 

                else

                     fprintf(file_id,'Handwritten');
                     class = 'Handwritten';

                end    

            else

                if(mve(i) <= 171)

                    if(mhpd <= 6120)

                        if(vpv(i) <= 12231255.28)
                             fprintf(file_id,'Printed');
                             class = 'Printed';
                        else
                            fprintf(file_id,'Handwritten');
                            class = 'Handwritten';
                        end    

                    else

                            fprintf(file_id,'Handwritten');
                            class = 'Handwritten';

                    end    

                else

                    if(pd(i) <= 32.45)

                            fprintf(file_id,'Printed');
                            class = 'Printed';

                    else

                           if(vpv(i) <= 16309649.77)

                                fprintf(file_id,'Printed');
                                class = 'Printed';

                           else

                               if(mve(i) <= 204)

                                    fprintf(file_id,'Handwritten');
                                    class = 'Handwritten';

                               else

                                   if(mhpd(i) <= 13260)

                                        fprintf(file_id,'Printed');
                                        class = 'Printed';

                                   else

                                        fprintf(file_id,'Handwritten');
                                        class = 'Handwritten';

                                   end    

                               end    
                           end    

                    end     

                end    


            end    



            %display((vpv(i)));
            %display(pd(i));
            %display(mve(i));
            fprintf(file_id,'\n');
            %imtool(filename);
            %prompt = 'Classifier predicted as : ';
            %c = input(prompt,'s');
            %display(class);
            if(strcmp(class,'Printed'))
                number_printed_words = number_printed_words+1;
            else
                number_handwritten_words = number_handwritten_words + 1;
            end    
        end
        
        fprintf(ph_file_id,'%f', (number_printed_words/total_number_words));
        fprintf(ph_file_id,',');
        fprintf(ph_file_id,'%f', (number_handwritten_words/total_number_words));
        fprintf(ph_file_id,',');
        
        %display(subfolder_names(iterate).name);
        %if(number_handwritten_words > (total_number_words*.20) )
        %    display('this Image consists Handwritten words');
         %   fprintf(ph_file_id,'Handwritten');
        %else
         %   display('this Image consists Printed words');
         %   fprintf(ph_file_id,'Printed');
       % end
       fprintf(ph_file_id,'Printed'); 
       fprintf(ph_file_id,'\n');
end
fclose(file_id);
fclose(ph_file_id);
%display('feature extraction completed succesfully');

