%this function is for generating line names
function default_file_name = generating_line_names()
        default_file_name= cell(676,1);
        k=1;
        s = char(97:122);
        for i=1:length(s)
            for j=1:length(s)
                 string = strcat(s(i),s(j));
                 default_file_name{k} = string;
                 k=k+1;
            end
        end    
        
end        