function [ result ] = predictionOutput( featMatrix )
%{
This function abstracts all matlab codes, for the script written in python

**inputs**
    window: epoch to be classified 

**outputs**
    result: prediction output. takes a value of 1 (bending seizure) or 0 (no seizure)
%}
addpath('./Features');
addpath('./Preprocessing');
load('trainedModel'); %loading the prediction model

% processedWindow = preprocessingMain(window);
% featMatrix = featuresMain(processedWindow);

result = svmclassify(svmmodel, featMatrix); %outputs either 0 or 1
end

