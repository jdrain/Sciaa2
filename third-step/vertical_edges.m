%this code is used to find the vertical edges of the words, to find out if
%the word is printed or handwritten.

function vertical_edge_value = vertical_edges(filename)
    %inverse_img = imread('C:\Users\akhil\Documents\MATLAB\Allfiles\Individual_Words_first\OnlyHandwritten\38AL0081_68-1-1_Revisit_1a\line10.png4.png');
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
    vertical_edges_list=sum(sum_image,1);
    
    vertical_edge = sum(vertical_edges_list);
    
    vertical_edge_value = (vertical_edge/(row*column));

    %creating vertical edges using the structuring elements
    %[rows, columns] = size(img);


    %ans = getnhood(strel('rectangle',[20,1]))

    %dilate_image = imdilate(img,strel('line',35,90));
    %dialate_area = bwarea(dilate_image);
    %ans2 = dialate_area/img_area;
    %imtool(dilate_image);

end