srcFiles = dir('C:\Users\akhil\Documents\MATLAB\Individual_lines\*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\akhil\Documents\MATLAB\Individual_lines\',srcFiles(i).name);
    img = imread(filename);
    [rows columns] = size(img);
    if(rows < 20)
        delete(filename);
    end
end