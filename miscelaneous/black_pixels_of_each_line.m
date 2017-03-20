%inverse_img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\OnlyHandwritten\38AL0081_68-1-1_Revisit_1a\line10.png4.png');
function sum_black_pixels_each_line = black_pixels_of_each_line(filename)
    %inverse_img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\OnlyHandwritten\38AL0081_68-1-1_Revisit_1a\line10.png4.png');
    inverse_img = imread(filename);
    img = inverse_img > 210;
    img = imcomplement(img);
    [rows,width] = size(img);
    black_pixels = sum(img,2);
    black_pixels_each_line = black_pixels/width;
    sum_black_pixels_each_line = sum(black_pixels_each_line);
    clear -except sum_black_pixels_each_line
end    