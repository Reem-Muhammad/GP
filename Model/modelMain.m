function [trainedModel] = modelMain(FEATURES, LABELS)


trainingPercentage = 0.7;

opts = statset('Display', 'Iter', 'MaxIter', 1000000);
FEATURES(FEATURES == inf) = 0; %replace infinity values of the features with 0

%Balance the data
[LABELS_balanced, FEATURES_balanced] = dataBalancing(LABELS, FEATURES);

%select the most descriminative features
%feature selection using t-test
[FEATURES_discriminative, selectedFeatures_idx] = featureSelection( FEATURES_balanced, LABELS_balanced );
%{
%feature selection using sequential feature selection method
fsOpts = statset('Display', 'Iter');
evalFunc = @errorFunc;
selectedFeatures_idx = sequentialfs(evalFunc, FEATURES_balanced, LABELS_balanced, 'options', fsOpts);
FEATURES_discriminative = FEATURES_balanced(:,selectedFeatures_idx);
%}
%normalize the features
FEATURES_normalized = real(normalize_feats(real(FEATURES_discriminative)));
%FEATURES_normalized = FEATURES_discriminative; %no normalization


%Partitioning the data into training and testing
[FEATURES_training, LABELS_training, FEATURES_testing, LABLES_testing] = dataPartition(FEATURES_normalized, LABELS_balanced, trainingPercentage);

feat_str= {'SD', 'FD', 'Hurst', 'Kurtosis', 'Skew', 'FI', 'Mobility', 'Mean Ab Val', 'Max Ab Val', 'Min Ab Val', 'RMS', 'Spec Centroid', 'Var Coeff'};
selectedFeatures_str = feat_str(selectedFeatures_idx);

%training using RBF kernel
trainedModel = svmtrain(FEATURES_training, LABELS_training, 'kernel_function', 'rbf', 'options',opts);

[TP, TN, FP, FN]=confusionMatrix(FEATURES_testing, LABLES_testing, trainedModel);

sensitivity = (TP/(TP + FN))*100;
specificity = (TN/(FP + TN))*100;
accuracy = ((TP+TN)/length(LABLES_testing))*100;
    
fprintf('Sensitivity: %7.3f,/tSpecificity: %7.3f/tAccuracy: %7.3f', sensitivity, specificity, accuracy);
end