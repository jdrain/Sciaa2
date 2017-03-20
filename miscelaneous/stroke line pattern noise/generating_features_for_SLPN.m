file_id = fopen('C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\training files\binarized_larger_printed_files38AL0023_68-1-2_Revisit_2.arff','at');
img = imread('C:\Users\akhil\Documents\MATLAB\binarized_printed_original_files\binarized_larger_printed_files\binarized_larger_printed_files38AL0023_68-1-2_Revisit_2.pdf.tiff.png');
%img = logical(img); %ver bad programming instead a thresholding algorithm needs to be used
abc = imcomplement(img);
abc1 = imcomplement(abc);
stats = regionprops(abc,'Area','Perimeter','ConvexArea','Orientation','MajorAxisLength','MinorAxisLength','Eccentricity','FilledArea','Extent','Solidity','EquivDiameter','BoundingBox');
%background needs to be non-zeros and all the foreground(text) needs to be
%zeros. bwdist calculates the distance between the pixels and the non-zeros
%
Dist=bwdist(abc1);
imtool(abc1);
[rows,columns] = size(stats);
area = cat(1,stats.Area);

table = struct2table(stats);
writetable(table,'C:/Users/akhil/Documents/WEKA/stroke_width_pattern_noise/output_boundingbox/binarized_larger_printed_files38AL0023_68-1-2_Revisit_2.xlsx');


fprintf(file_id,'%s','% 1. Title: SCIAA Classifying printed and Handwritten text');
fprintf(file_id,'\n');
fprintf(file_id,'%s','%');
fprintf(file_id,'\n');
fprintf(file_id,'%s','% 2. Sources:');
fprintf(file_id,'\n');
fprintf(file_id,'%s','% (a) Creator: Akhil Katpally');
fprintf(file_id,'\n');
fprintf(file_id,'%s','% (b) Donor: SCIAA');
fprintf(file_id,'\n');
fprintf(file_id,'%s','% (c) Date: September, 2016');
fprintf(file_id,'\n');
fprintf(file_id,'%s','%');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@RELATION SCIAA');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE Area  	NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE MajorAxisLength   	NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE MinorAxisLength  	NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE Eccentricity   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE Orientation   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE ConvexArea   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE FilledArea   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE EquivDiameter   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE Solidity   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE Extent   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE Perimeter   NUMERIC');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@ATTRIBUTE class        {''Text'', ''Noise''}');
fprintf(file_id,'\n');
fprintf(file_id,'%s','@DATA');
fprintf(file_id,'\n');

for i=1:rows
    
   fprintf(file_id,'%.2f',stats(i).Area);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).MajorAxisLength);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).MinorAxisLength);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).Eccentricity);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).Orientation);
   fprintf(file_id,',');
   fprintf(file_id,'%d',stats(i).ConvexArea);
   fprintf(file_id,',');
   fprintf(file_id,'%d',stats(i).FilledArea);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).Extent);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).Solidity);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).EquivDiameter);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).Perimeter);
   fprintf(file_id,',');
   fprintf(file_id,'%s','?');
   fprintf(file_id,'\n');
end 
fclose(file_id);