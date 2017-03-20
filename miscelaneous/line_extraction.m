clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
tic;
%fullFileName = fullfile(pwd, 'crop.png');

grayImage = imread('C:\Users\akhil\Documents\MATLAB\line.png');
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	 % Take green channel.
end
% Display the original gray scale image.
subplot(2, 3, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', 20, 'Interpreter', 'None');
axis on;

% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

binaryImage = grayImage > 210;
subplot(2, 3, 2);
imshow(binaryImage);
title('Binary Image', 'FontSize', 20, 'Interpreter', 'None');
axis on;

% _summing the image horizontally_
verticalProfile = sum(binaryImage, 2);

subplot(2, 3, 3);
plot(verticalProfile, 'b-');
grid on;
title('Vertical Profile original ', 'FontSize', 20, 'Interpreter', 'None');

% _create logical vector of what lines have text and which do not based on
%threshold_
thresh = max(verticalProfile) - max(verticalProfile)/10 - mod(max(verticalProfile),100);
rowsWithText = verticalProfile < thresh;

% _finding top and bottom lins_
topLines = find(diff(rowsWithText) == 1);
bottomLines = find(diff(rowsWithText) == -1);

% _looping for extracting characters in the image_
for k = 1 : length(topLines)  % _loop for segmenting horizontal lines_
	topRow = topLines(k);
	bottomRow = bottomLines(k);
	thisLine = binaryImage(topRow:bottomRow, :);
	subplot(2, 3, 4);
	imshow(thisLine, []);
    filename = strcat('C:\Users\akhil\Documents\MATLAB\abc',int2str(k));
    filename = strcat(filename , '.png');
    imwrite(thisLine,filename);
	axis on;
	caption = sprintf('Line %d of the text', k);
	title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
	
	% _summing the segmented image vertically_
	horizontalProfile = sum(thisLine, 1);
	subplot(2, 3, 5);
	plot(horizontalProfile, 'b-');
	grid on;
	caption = sprintf('Horizontal Profile of Line %d of the text', k);
	title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

	theThreshold = 0.8 * abs(topRow-bottomRow);
	columnWithText = horizontalProfile < theThreshold;
	leftCharacter = find(diff(columnWithText) == 1);
	rightCharacter = find(diff(columnWithText) == -1);
	if isempty(leftCharacter) || isempty(rightCharacter)
		continue;
    end
    horizontalProfile1 = mean(thisLine, 1);
    darkColumns = horizontalProfile < 50;
    labeledColumns = bwlabel(darkColumns);
    word3 = ismember(labeledColumns, 3); 
    imshow(word3);
	promptMessage = sprintf('This is the image between rows %d and %d, inclusive.\nDo you want to find letters within this line,\nor Cancel to abort processing?', topRow, bottomRow);
	titleBarCaption = 'Continue?';
	button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
	if strcmpi(button, 'Cancel')
		return;
	end
	
	subplot(2, 3, 6);
end