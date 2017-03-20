function pixel_distribution_value = pixel_distribution(filename)
    img = imread(filename);
    [rows,columns]=size(img);
    middle_value = floor(rows/2);
    complement_image = imcomplement(img);
    upper_image=zeros((middle_value-10),columns);
    lower_image=zeros(((middle_value+1)-(rows-10)),columns);
    n=1;
    for i=11:middle_value
       for j=1:columns
           upper_image(n,j) = complement_image(i,j);
       end
       n=n+1;
    end    
    %imtool(upper_image);

    abc_upper_image = sum(upper_image,1);
    number_of_pixels_upper_image = sum(abc_upper_image,2);
    [rows_upper_image,columns_upper_image] = size(upper_image);
    area_upper_image = rows_upper_image * columns_upper_image;
    density_of_upper_image = number_of_pixels_upper_image/area_upper_image;

    k=1;
    for i=(middle_value+1):(rows-10)
       for j=1:columns
           lower_image(k,j) = complement_image(i,j);
       end
       k=k+1;
    end    
    %imtool(lower_image);

    abc_lower_image = sum(lower_image,1);
    number_of_pixels_lower_image = sum(abc_lower_image,2);
    [rows_lower_image,columns_lower_image] = size(lower_image);
    area_lower_image = rows_lower_image * columns_lower_image;
    density_of_lower_image = number_of_pixels_lower_image/area_lower_image;

    pixel_distribution_value = abs(density_of_upper_image - density_of_lower_image);
end