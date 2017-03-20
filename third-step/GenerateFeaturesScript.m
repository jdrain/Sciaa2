%
% Author: Jason Drain
% Date: 2/22/2017
%
% Usage: GenerateFeaturesScript(<county filepath>)
%
% Description:
%
% Script to run the first half of the generating features (third)
% step.
%
% 1) removeHWNumber(<county filepath>)
% 2) removeHeader(<county filepath>)
% 3) LineExtraction(<county filepath>, <individual lines destination dir>)
% 4) WordExtraction(<individual lines>, <individual words>)
% 5) RemovingWhiteSpaceAtWordBoder(<individual words>)
% 6) GeneratingFeatures(<individual words>, <ARFF files destination dir>)
% 
% The next step is large and small image classification which is done with
% Java
%

% This file should just take in the county filepath and construct the 
% other needed filepaths from this
% individualLines = countyFilepath+"IndividualLines"
% individualWords = countyFilepath+"IndividualWords"
% ARFF = countyFilepath+"ARFF"

function [] = GenerateFeaturesScript(countyFilepath)
    
    %if the format of countyFilepath is wrong:
    if (countyFilepath(length(countyFilepath)) ~= '\')
        fprintf('\nThe filepath must end with a backslash\n')
    else
        %define our vars 
        individualLines = strcat(countyFilepath,'IndividualLines\');
        individualWords = strcat(countyFilepath,'IndividualWords\');
        
        %make the ARFF and subfolders if they don't exist
        ARFF = strcat(countyFilepath,'ARFF\');
        Large = strcat(ARFF,'Large\');
        Small = strcat(ARFF,'Small\');
        
        if ~exist(ARFF,'dir')
            mkdir(ARFF);
            mkdir(Large);
            mkdir(Small);
        else
            if ~exist(Large,'dir')
                mkdir(Large);
            end
            if ~exist(Small,'dir')
                mkdir(Small);
            end
        end

        %run the scripts in succession
        fprintf('\nRunning remove HWNumber: \n')
        removeHWNumber(countyFilepath)

        fprintf('\nRunning removeHeader: \n')
        removeHeader(countyFilepath)

        fprintf('\nRunning LineExtraction: \n')
        LineExtraction(countyFilepath,individualLines)

        fprintf('\nRunning WordExtraction: \n')
        WordExtraction(individualLines,individualWords)

        fprintf('\nRunning RemovingWhiteSpaceAtWordBorder: \n')
        RemovingWhiteSpaceAtWordBorder(individualWords)

        fprintf('\nRunning GeneratingFeatures: \n')
        GeneratingFeatures(individualWords,ARFF)
        %UNFINISHED
    end
end
    
    