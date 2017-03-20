img = imread('C:\Users\akhil\Documents\MATLAB\Individual_words\lineimages4.png3.png');
imtool(img);
% Threshold
binarySignal = img < 500;
% Get rid of runs less than 20
binarySignal = bwareaopen(binarySignal, 20);
% Label and find centroids of remaining big gaps
labeledSignal = bwlabel(binarySignal);
measurements = regionprops(labeledSignal, 'Centroid');
% Extract word 1 as a new image.
word1 = img(:, 1:measurements(1).Centroid);