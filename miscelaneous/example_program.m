%this program is just for extracting names of the printed and handwritten
%files.
clear;
clc;

names  = dir('C:\Users\akhil\Documents\MATLAB\Allfiles\output_original_files\printed\*.png');

for i=1:length(names) 
    printed_file_names = strsplit(names(i).name,'.pdf');
    total_file_name = strcat(printed_file_names(1),'.arff');
    filenames(1).source = fullfile('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_predictions\',total_file_name);
    destination(1).destination = fullfile('C:\Users\akhil\Documents\MATLAB\Allfiles\predictions_for_training_file\printed\',total_file_name);
    %filenames = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_predictions\',total_file_name);
    %destination = strcat('C:\Users\akhil\Documents\MATLAB\Allfiles\predictions_for_training_file\printed\',total_file_name);
    copyfile(filenames(1).source,destination(1).destination);
end   

