clear all;
img= imread('C:\Users\akhil\Documents\MATLAB\Individual_lines\lineimages6.png');
i=imcomplement(img);
i=padarray(i,[0 10]);
verticalProjection = sum(i, 1);
set(gcf, 'Name', 'DEMO BY SOUMYADEEP', 'NumberTitle', 'Off') 
subplot(2, 2, 1);imshow(i); 
subplot(2,2,3);
plot(verticalProjection, 'b-');
grid on;
t = verticalProjection;
t(t==0) = inf;
mayukh=min(t)
% 0 where there is background, 1 where there are letters
letterLocations = verticalProjection > mayukh; 
% Find Rising and falling edges
d = diff(letterLocations);
startingColumns = find(d>0);
endingColumns = find(d<0);
% Extract each region
y=1;
for k = 1 : length(startingColumns)
  % Get sub image of just one character...
  subImage = i(:, startingColumns(k):endingColumns(k)); 
[L,num] = bwlabel(subImage);
for z= 1 : num
bw= ismember( L, z);
% Construct filename for this particular image.
baseFileName = sprintf('curvedimage %d.png', y);
 y=y+1;
% Prepend the folder to make the full file name.
fullFileName = fullfile('C:\Users\akhil\Documents\MATLAB\Individual_lines\', baseFileName);
% Do the write to disk.
imwrite(bw, fullFileName);
subplot(2,2,4);
pause(2);
imshow(bw);
end;
y=y+1;
end;