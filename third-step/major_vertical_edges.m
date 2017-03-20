%this code is used to find the vertical edges of the words, to find out if
%the word is printed or handwritten.

function major_vertical_edge_value = major_vertical_edges(filename)

    inverse_img = imread(filename);
    img = imcomplement(inverse_img);
    %img_area = bwarea(img);
    %imtool(img);
    %BW = edge(img,'prewitt',[],'vertical'); 

    %img_size = size(img);
    h1=[1,0,-1;1,0,-1;1,0,-1;1,0,-1;1,0,-1;1,0,-1;1,0,-1];
    edges_img1 = imfilter(img,h1);
    %edge_area1 = bwarea(edges_img1);
    %ans1 = edge_area1/img_area;
    %imtool(edges_img1);

    h2=[-1,0,1;-1,0,1;-1,0,1;-1,0,1;-1,0,1;-1,0,1;-1,0,1];
    edges_img2 = imfilter(img,h2);
    %imtool(edges_img2);
    sum_image = edges_img1 + edges_img2;
    [row column] = size(sum_image);
    %imtool(sum_image);
    vertical_edge=sum(sum_image,1);
    black_pixels_major_vertical_edge = max(vertical_edge);

    major_vertical_edge_value = (black_pixels_major_vertical_edge/row);

    %creating vertical edges using the structuring elements
    %[rows, columns] = size(img);


    %ans = getnhood(strel('rectangle',[20,1]))

    %dilate_image = imdilate(img,strel('line',35,90));
    %dialate_area = bwarea(dilate_image);
    %ans2 = dialate_area/img_area;
    %imtool(dilate_image);

end