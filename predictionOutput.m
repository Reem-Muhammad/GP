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
%normalizedWindow = normalize_feats(featMatrix);%----->>
result = svmclassify(svmmodel, featMatrix ); %outputs either 0 or 1



% for i = [1:13057]
%     normalizedWindow = normalize_feats(featMatrix(i,:));
%     result = svmclassify(svmmodel, normalizedWindow);
%     finalRes = [finalRes; result];
% end

