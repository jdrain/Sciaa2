file_id = fopen('C:\Users\akhil\Documents\MATLAB\stroke_pattern_line_noise\third1.arff','at');
img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0009_68-1-2_Revisit_1b.pdf.tiff.png');
img = logical(img); %ver bad programming instead a thresholding algorithm needs to be used
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
% average = mean(area);
max_area = max(area);
min_area = min(area);
new_areas = (area-min_area)/(max_area-min_area);
new_max_area = max(new_areas);
new_min_area = min(new_areas);

imported_decision = importdata('C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output\first_image.arff.xlsx');

% Manually entering if the componenet is either Noise or Text
for i=2:rows
     imshow(abc);
      bb = stats(i).BoundingBox;
      rectangle('position',[bb(1) bb(2) bb(3) bb(4)],'EdgeColor','red');
      disp(i);
     str = input('Enter whether it is Text or Noise : ','s'); %taking the
    %input from the standard input
    %str = VarName14{i+1};
%    [stats(i).Decision] = deal(imported_decision{i-1});
end

% Calculating the stroke Width of all the components in the image
for j=2:rows
   max=0; 
   bb = stats(j).BoundingBox;
   %disp(bb);
   for k=bb(2):bb(2)+bb(4)
       for l=bb(1):bb(1)+bb(3)
            if(Dist(floor(k),floor(l))> max)
                max = Dist(floor(k),floor(l));
            end   
       end     
   end
   [stats(j).StrokeWidth] = deal(max);
    
end   

%calculating the mode of the storke width of the PTC's
i=0;
for j=2:rows
    
    if(strcmp(stats(j).Decision,'Text'))
        i=i+1;
        disp(stats(j).Decision);
        %str = input('Enter whether it is Text or Noise : ','s');
    end   
end    

mode_ptc(i)=0;
k=1;
for j=2:rows
    
    if(strcmp(stats(j).Decision,'Text'))
        mode_ptc(k) = stats(j).StrokeWidth;
        k=k+1;
    end   
end
mode_average_ptc = mode(mode_ptc);

%creating an image with just PTC(Text)
bbc = abc;
imwrite(bbc,'C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output\original.png');
for j=2:rows
    
    if(strcmp(stats(j).Decision,'Noise'))
        disp(j);
        bb = stats(j).BoundingBox;
        for k=bb(2):bb(2)+bb(4)
            for l=bb(1):bb(1)+bb(3)
                  bbc(floor(k),floor(l))=0; 
            end     
        end
    end   
    
    
end    

imwrite(bbc,'C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output\cleaned.png');
Background_Dist=bwdist(bbc);
%calculating the Cohesion for the Non-PTC (Noise)
for j=2:rows
    min=Background_Dist(floor(bb(2)),floor(bb(1)));
    if(strcmp(stats(j).Decision,'Noise'))
        disp(j);
        bb = stats(j).BoundingBox;
        for k=bb(2):bb(2)+bb(4)
            for l=bb(1):bb(1)+bb(3)
                    if(Background_Dist(floor(k),floor(l))< min)
                        min = Background_Dist(floor(k),floor(l));
                    end   
            end     
        end
        [stats(j).Cohesion] = deal(min);
    end   
end    

% str = input('Enter whether it is Text or Noise : ','s');
% just_single_ptc = bbc;
% just_single_ptc(:) = 0;
% average_distance = 0;
% count = 0;
% for j=2:rows
%    if(strcmp(stats(j).Decision,'''Text'''))
%        just_single_ptc(:) = 0;
%         bb = stats(j).BoundingBox;
%         for k=bb(2):bb(2)+bb(4)
%             for l=bb(1):bb(1)+bb(3)
%                 just_single_ptc(floor(k),floor(l))=1;
%             end
%         end
%         
%         single_dist=bwdist(just_single_ptc);
%         smallest_distance=10000;
%         str = input('Enter whether it is Text or Noise : ','s');
%         for z=2:rows
%             
%             if((j~=z) && strcmp(stats(z).Decision,'''Text'''))
%                 distance=single_dist(floor(bb(2)),floor(bb(1)));
%                 for k=bb(2):bb(2)+bb(4)
%                     for l=bb(1):bb(1)+bb(3)
%                         if(single_dist(floor(k),floor(l))< distance)
%                             distance = single_dist(floor(k),floor(l));
%                         end   
%                     end     
%                 end
%                 if(distance<smallest_distance)
%                    smallest_distance = distance; 
%                 end          
%             end    
%         end 
%         average_distance = average_distance + smallest_distance;
%         count = count + 1;
%    end
%    
% end  
% average_distance = average_distance/count;
% 

for i=3:rows
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
   fprintf(file_id,'%.4f',stats(i).StrokeWidth);
   fprintf(file_id,',');
   fprintf(file_id,'%.4f',stats(i).Cohesion);
   fprintf(file_id,',');
   fprintf(file_id,'%s',stats(i).Decision);
   fprintf(file_id,'\n');
end    

fclose(file_id);
% 
% for j=2:rows
%    max=0; 
%    bb = stats(j).BoundingBox;
%    abcpixels = boundingboxPixels(abc, bb(1),bb(2),bb(3),bb(4));
%    %[stats(j).StrokeWidth] = deal(max);
%     
% end  



