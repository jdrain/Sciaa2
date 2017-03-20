% Demo to find the closest vectors from one binary blob's boundaries to the other binary blob boundaries.
% Draws lines between each pair of boundaries along the closest distance path.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 24;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

%===============================================================================
% Read in a standard MATLAB demo image.
%folder = fileparts(which('eight.tif')); % Determine where demo folder is (works with all versions).
%baseFileName = 'eight.tif';
% Get the full filename, with path prepended.
%fullFileName = fullfile(folder, baseFileName);
% fullFileName = 'C:\Users\akhil\Documents\MATLAB\Allfiles\Original_Files\38AL0009_68-1-2_Revisit_1b.pdf.tiff.png';
% ff = 'C:\Users\akhil\Documents\MATLAB\stroke_pattern_line_noise\cleaned_only_text1.png';
% if ~exist(fullFileName, 'file')
% 	% Didn't find it there.  Check the search path for it.
% 	fullFileName = baseFileName; % No path this time.
% 	if ~exist(fullFileName, 'file')
% 		% Still didn't find it.  Alert user.
% 		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
% 		uiwait(warndlg(errorMessage));
% 		return;
% 	end
% end
% grayImage = imread(fullFileName);
% g1 = imread(ff);
% % Get the dimensions of the image.  
% % numberOfColorBands should be = 1.
% [rows, columns, numberOfColorBands] = size(grayImage);
% if numberOfColorBands > 1
% 	% It's not really gray scale like we expected - it's color.
% 	% Convert it to gray scale by taking only the green channel.
% 	grayImage = grayImage(:, :, 2); % Take green channel.
% end
% % Display the original gray scale image.
% subplot(2, 2, 1);
% imshow(grayImage, []);
% title('Original Grayscale Image', 'FontSize', fontSize);
% % Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% % Give a name to the title bar.
% set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 
% 
% % Let's compute and display the histogram.
% [pixelCount, grayLevels] = imhist(grayImage);
% subplot(2, 2, 2); 
% bar(grayLevels, pixelCount);
% grid on;
% title('Histogram of original image', 'FontSize', fontSize);
% xlim([0 grayLevels(end)]); % Scale x axis manually.
% 
% % Threshold the gray scale image to make a binary image.
% binaryImage = grayImage < 200;
% 
% % Fill the outline to make it solid so we don't get boundaries
% % on both the inside of the shape and the outside of the shape.
binaryImage = imread('C:\Users\akhil\Documents\MATLAB\stroke_pattern_line_noise\cleaned_only_text1.png');
binaryImage = imfill(binaryImage, 'holes');
% Get rid of small regions:
%binaryImage = bwareaopen(binaryImage, 2500);
% Display the image.
subplot(2, 2, 3);
imshow(binaryImage);
axis on;
title('Binary Image', 'FontSize', fontSize);

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
subplot(2, 2, 4);
imshow(binaryImage);
axis on;
title('Binary Image', 'FontSize', fontSize);
title('Showing Closest Distances', 'FontSize', fontSize);
hold on;
boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth', 3);
end
hold off;

% Define object boundaries
numberOfBoundaries = size(boundaries, 1);
% message = sprintf('Found %d boundaries', numberOfBoundaries);
% uiwait(helpdlg(message));
% Find minimum distance between each pair of boundaries
distance(numberOfBoundaries,numberOfBoundaries)=999999;
for b1 = 1 : numberOfBoundaries
    
	for b2 = 1 : numberOfBoundaries
		if b1 == b2
			% Can't find distance between the region and itself
			continue;
		end
		boundary1 = boundaries{b1};
		boundary2 = boundaries{b2};
		boundary1x = boundary1(:, 2);
		boundary1y = boundary1(:, 1);
		x1=1;
		y1=1;
		x2=1;
		y2=1;
		overallMinDistance = inf; % Initialize.
		% For every point in boundary 2, find the distance to every point in boundary 1.
		for k = 1 : size(boundary2, 1)
			% Pick the next point on boundary 2.
			boundary2x = boundary2(k, 2);
			boundary2y = boundary2(k, 1);
			% For this point, compute distances from it to all points in boundary 1.
			allDistances = sqrt((boundary1x - boundary2x).^2 + (boundary1y - boundary2y).^2);
			% Find closest point, min distance.
			[minDistance(k), indexOfMin] = min(allDistances);
			if minDistance(k) < overallMinDistance
				x1 = boundary1x(indexOfMin);
				y1 = boundary1y(indexOfMin);
				x2 = boundary2x;
				y2 = boundary2y;
				overallMinDistance = minDistance(k);
			end
		end
		% Find the overall min distance
		minDistance = min(minDistance);
        distance(b1,b2)=minDistance;
		% Report to command window.
		fprintf('The minimum distance from region %d to region %d is %.3f pixels\n', b1, b2, minDistance);

		% Draw a line between point 1 and 2
		line([x1, x2], [y1, y2], 'Color', 'y', 'LineWidth', 3);
	end
end