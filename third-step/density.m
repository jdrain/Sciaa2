%it calculates the density of the bounding boxes

function density_value = density(filename)
    %inverse_img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\OnlyHandwritten\38AL0081_68-1-1_Revisit_1a\line10.png4.png');
    inverse_img = imread(filename);
    img = imcomplement(inverse_img);
    sum_value = sum(img,1);
    number_of_pixels = sum(sum_value,2);
    [rows,columns] = size(img);
    area = rows * columns;
    density_value = (number_of_pixels/(area));
end
%density('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\OnlyHandwritten\38AL0081_68-1-1_Revisit_1a\line10.png4.png');
