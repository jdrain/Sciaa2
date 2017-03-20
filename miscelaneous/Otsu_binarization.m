% this method is used for the binarization of the grayscale images. All the
% tesseract results of the original grayscale and the binarized images are
% exact (100%). There is no data loss in this method.

folder_path = 'C:\Users\akhil\Documents\MATLAB\printed_original_files\larger_printed\';
binarized_folder_path = 'C:\Users\akhil\Documents\MATLAB\binarized_printed_original_files\binarized_larger_printed_files\';
all_files = strcat(folder_path,'*.png');
srcFiles = dir(all_files);
for i=1:length(srcFiles)
  filename = strcat(folder_path,srcFiles(i).name);      
  binarized_filename = strcat(binarized_folder_path,srcFiles(i).name);
  img = imread(filename);
  level = graythresh(img);
  BW = im2bw(img,level);
  imwrite(BW, binarized_filename);  
end    