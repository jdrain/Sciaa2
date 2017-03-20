%it calculates the density of the bounding boxes

function deviation = deviation_width_height_area(average,filename)
    %inverse_img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\OnlyHandwritten\38AL0081_68-1-1_Revisit_1a\line10.png4.png');
    inverse_img = imread(filename);
    img = imcomplement(inverse_img);
    [r,c]=size(img);
    area = r*c;
    deviation.width = abs((c-average.width));
    deviation.height = abs((r-average.height));
    deviation.area = abs((area-average.area));
end
