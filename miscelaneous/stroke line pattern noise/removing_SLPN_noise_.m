%creating an image with just PTC(Text)

img = imread('C:\Users\akhil\Documents\MATLAB\binarized_printed_original_files\binarized_larger_printed_files\binarized_larger_printed_files38AL0023_68-1-2_Revisit_2.pdf.tiff.png');
%img = logical(img); %ver bad programming instead a thresholding algorithm needs to be used
abc = imcomplement(img);
bbc=abc;
abc=imcomplement(abc);
imwrite(abc,'C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output\original.png');




boundingbox = importdata('C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output_boundingbox\binarized_larger_printed_files38AL0023_68-1-2_Revisit_2.xlsx');
decision = importdata('C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output\binarized_larger_printed_files38AL0023_68-1-2_Revisit_2.arff.xlsx');
%just to know the number of the regions in the image
[rows,columns] = size(decision);

for j=1:rows
    
    if(strcmp(decision(j),'Noise'))
        disp(j);
        bbx = boundingbox.data(j,2);
        bby = boundingbox.data(j,3);
        bbw = boundingbox.data(j,4);
        bbh = boundingbox.data(j,5);
        for k=bby:bby+bbh
            for l=bbx:bbx+bbw
                  bbc(floor(k),floor(l))=0; 
            end     
        end
    end   
end    
bbc=imcomplement(bbc);
imwrite(bbc,'C:\Users\akhil\Documents\WEKA\stroke_width_pattern_noise\output\cleaned.png');