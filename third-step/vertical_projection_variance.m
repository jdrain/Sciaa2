

function variance = vertical_projection_variance(filename)
    img = imread(filename);
    
    
    
    verticalProfile1 = sum(img,1);
    %variance value is used to find out if it is printed or handwritten value.
    %We can use the if statement to find out handwritten or printed. If it is
    %less than 99 then it is handwritten.
    variance = var(verticalProfile1);
    %meanvalue = mean(verticalProfile1);
    
    %Not using it because var() function itself does all the work instead of
    %the below function
    %sum =0;
    %for i=1:length(verticalProfile1)
    %   sum = sum + (meanvalue-verticalProfile1(1))^2;
    %end    
    
    %to plot the vertical Projection of the image
    %subplot(2, 3, 1);
    %plot(verticalProfile1);
    %grid on;
    %title('Vertical Profile Modified abc', 'FontSize', 20, 'Interpreter', 'None');
    %imtool(img);
end


