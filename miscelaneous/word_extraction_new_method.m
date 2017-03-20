%this method is not working properly

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
% Read in a standard MATLAB gray scale demo image.
folder = 'C:\Users\akhil\Documents\MATLAB\Allfiles\july-cleaning\smaller_output_original_files\printed\Individual_Files\38AL0005_68-1-1_Revisit_1a\';
baseFileName = 'line_aa.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 3, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst for Dwi Putra Alexander','numbertitle','off');

% Convert to grayscale
if numberOfColorBands > 1
	grayImage = grayImage(:,:,2); % Take green channel
end
% Let's compute and display the histogram.
[pixelCount grayLevels] = imhist(grayImage);
subplot(2, 3, 2); 
bar(pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
% Threshold the image.
binaryImage = grayImage < 175;
% Display the image.
subplot(2, 3, 3);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);
% Dilate to connect all the letters
binaryImage = imdilate(binaryImage, true(7));
% Get rid of blobs less than 200 pixels (the dot of the i).
binaryImage = bwareaopen(binaryImage, 200);
% Display the image.
subplot(2, 3, 3);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);
% Find the areas and bounding boxes.
measurements = regionprops(binaryImage, 'Area', 'BoundingBox');
allAreas = [measurements.Area]
% Crop out each word
for blob = 1 : length(measurements)
	% Get the bounding box.
	thisBoundingBox = measurements(blob).BoundingBox;
	% Crop it out of the original gray scale image.
	thisWord = imcrop(grayImage, thisBoundingBox);
	% Display the cropped image
	subplot(2,3, 3+blob); % Switch to proper axes.
	imshow(thisWord); % Display it.
	% Put a caption above it.
	caption = sprintf('Word #%d', blob);
	title(caption, 'FontSize', fontSize);
end
