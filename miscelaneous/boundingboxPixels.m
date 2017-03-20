function pixel_vals = boundingboxPixels(img, x_init, y_init, x_width, y_width)

    if x_init > size(img,2) 
        error('x_init lies outside the bounds of the image.'); end
    if y_init > size(img,1)
        error('y_init lies outside the bounds of the image.'); end

    if y_init+y_width > size(img,1) || x_init+x_width > size(img,2) || ...
       x_init < 1 || y_init < 1
        warning([...
            'Given rectangle partially falls outside image. ',... 
            'Resizing rectangle...']);
    end

    x_min   = max(1, uint16(x_init));
    y_min   = max(1, uint16(y_init));
    x_max   = min(size(img,2), x_min+uint16(x_width));
    y_max   = min(size(img,1), y_min+uint16(y_width));
    x_range = x_min : x_max;
    y_range = y_min : y_max;

    Upper = img( x_range, y_min  , :);
    Left  = img(   x_min, y_range, :);
    Right = img(   x_max, y_range, :);
    Lower = img( x_range, y_max  , :);

    pixel_vals = [...
       Upper
       permute(Left, [2 1 3]) 
       permute(Right, [2 1 3])
       Lower];

end


