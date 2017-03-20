file_id = fopen('C:\Users\akhil\Documents\MATLAB\stroke_pattern_line_noise\second_image.arff','at');



for i=1:1524
    fprintf('\n');
    fprintf('\n');
    fprintf('\n');
    fprintf('\n');
   fprintf(file_id,'%.2f',Area(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',MajorAxisLength(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',MinorAxisLength(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',Eccentricity(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',Orientation(i));
   fprintf(file_id,',');
   fprintf(file_id,'%d',ConvexArea(i));
   fprintf(file_id,',');
   fprintf(file_id,'%d',FilledArea(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',Extent(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',Solidity(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',EquivDiameter(i));
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',Perimeter(i));
   fprintf(file_id,',');
%    fprintf(file_id,'%.4f',StrokeWidth(i));
%    fprintf(file_id,',');
%    fprintf(file_id,'%.4f',Cohesion(i));
%    fprintf(file_id,',');
   fprintf(file_id,'%s',Text{i});
   fprintf(file_id,'\n');
end    

fclose(file_id);