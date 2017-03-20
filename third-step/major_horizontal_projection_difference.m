%this code is used to find out the major horizontal projection difference
function mhp_difference = major_horizontal_projection_difference(filename)
    img = imread(filename);

    horizontalProfile1 = sum(img,2);

    for i=1:(length(horizontalProfile1)-1)
       difference(i) = abs(horizontalProfile1(i)-horizontalProfile1(i+1)); 
    end

    mhp_difference=max(difference);

end