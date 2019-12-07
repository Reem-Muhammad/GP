%directory where the features matrix and the corresponding labels are stored%
featureMatrixDir = 'G:\FeatureMatrix\chb03_features_labels.mat';

load(featureMatrixDir);

%find out the indices of both classes
onesidx = (label_vector_case == 1);
zerosidx = ~onesidx;

%initialize a column vector that will hold the t-values of the features
t_value = zeros(size(feature_matrix_case, 2) , 1);

%loop through each feature to calculate its t_value
for feature = 1: size(feature_matrix_case, 2)
    
    positiveClass = feature_matrix_case(onesidx, feature);
    negativeClass = feature_matrix_case(zerosidx, feature);
    
    positiveMean = nanmean(positiveClass);
    negativeMean = nanmean(negativeClass);
    
    positiveVar = nanvar(positiveClass);
    negativeVar = nanvar(negativeClass);
    
    t_value(feature) = (positiveMean - negativeMean)./ sqrt( (positiveVar ./ length(positiveClass)) + (negativeVar ./ length(negativeClass)) );
    
end