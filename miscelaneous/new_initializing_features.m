
clear;
clc;

subfolder_names=dir('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\printed\');
for iterate=3:length(subfolder_names)
        folder_path = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\printed\',subfolder_names(iterate).name);
        folder_path = strcat(folder_path,'\');
        all_files = strcat(folder_path,'*.png');
        srcFiles = dir(all_files);  % the folder in which ur images exists
        test_file_name = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\predictions_for_training_file\printed\',subfolder_names(iterate).name);
        test_file_name = strcat(test_file_name,'.arff');
        file_id = fopen(test_file_name,'at');
        fprintf(file_id,'@RELATION SCIAA');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE VerticalProjectionVariance  	NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE MajorHorizontalProjectionDifference   	NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE MajorVerticalEdge  	NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE pixelDistribution   NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE VerticalEdge   NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE Density   NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE DeviationWidth   NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE DeviationHeight   NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE DeviationArea   NUMERIC');
        fprintf(file_id,'\n');
        fprintf(file_id,'@ATTRIBUTE class        {Printed, Handwritten}');
        fprintf(file_id,'\n');
        fprintf(file_id,'@DATA');
        fprintf(file_id,'\n');
        
        
        vpv(:,1)=(0);
        pd(:,1)=(0);
        mhpd(:,1)=(0);
        mve(:,1)=(0);
        ve(:,1)=(0);
        
        dw(:,1)=(0);
        dh(:,1)=(0);
        da(:,1)=(0);
        average=average_width_height_areas(folder_path,srcFiles);
        for i = 1 : length(srcFiles)
            filename = strcat(folder_path,srcFiles(i).name);
            vpv(i) = vertical_projection_variance(filename);
            fprintf(file_id,'%.2f',vpv(i));
            fprintf(file_id,',');
            mhpd(i) = major_horizontal_projection_difference(filename);
            fprintf(file_id,'%d',mhpd(i));
            fprintf(file_id,',');
            mve(i) = major_vertical_edges(filename);
            fprintf(file_id,'%.2f',mve(i));
            fprintf(file_id,',');
            pd(i) = pixel_distribution(filename);
            fprintf(file_id,'%.2f',pd(i));
            fprintf(file_id,',');
            ve(i) = vertical_edges(filename);
            fprintf(file_id,'%.2f',ve(i));
            fprintf(file_id,',');
            den = density(filename);
            
            fprintf(file_id,'%.2f',den);
            fprintf(file_id,',');
            deviation = deviation_width_height_area(average,filename);
            dw(i)=deviation.width;
            fprintf(file_id,'%.2f',dw(i));
            fprintf(file_id,',');
            dh(i)=deviation.height;
            fprintf(file_id,'%.2f',dh(i));
            fprintf(file_id,',');
            da(i)=deviation.area;
            fprintf(file_id,'%.2f',da(i));
            fprintf(file_id,',');
            %imtool(filename);
            %display(i);
            %prompt = 'Is the image a Printed or Handwritten';
            %class = input(prompt,'s');
            fprintf(file_id,'?');

        
            %display((vpv(i)));
            %display(pd(i));
            %display(mve(i));
            %fprintf(file_id,'%s',class);
            fprintf(file_id,'\n');
            %imtool(filename);
            %prompt = 'Classifier predicted as : ';
            %c = input(prompt,'s');
            %display(class);
        end
        clear vpv pd mhpd mve ve density dw dh da
        fclose(file_id);
end

display('feature extraction completed succesfully');
