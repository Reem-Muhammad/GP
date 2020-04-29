function [LABELS_balanced, FEATURES_balanced]=dataBalancing(LABELS, FEATURES)
%{
Balancing the features by removing some instances of the majority class
%}
addpath('.\Preprocessing');
addpath('.\Features');

onesCount = sum(LABELS == 1);
zerosCount = sum(LABELS == 0);

LABELS_balanced = LABELS;
FEATURES_balanced = FEATURES;

if floor(zerosCount/onesCount) > 2
    randIdx = randperm(length(LABELS),(zerosCount-2*onesCount)); %generate random indices to be removed
    zeroIdx_toRemove = randIdx(LABELS(randIdx)==0); %extract only the indices that has a label of 0
    %LABELS(randIdx==0) returns the indices that have zero labels, in
    %randIdx not in LABELS
    %Some of randIdx have labels of 1. So you need to find which of these
    %indices have 0s 
    LABELS_balanced(zeroIdx_toRemove)=[];   %remove the extracted indices from the labels
    FEATURES_balanced(zeroIdx_toRemove, :)=[];  %remove the extracted indices from the features
    
end
end