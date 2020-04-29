function [trainingFeatures, trainingLabels, testingFeatures, testingLabels] = dataPartition(FEATURES, LABELS, trainingPercentage)
%{
trainingPercentage -> divided by 100 (i.e 0.8 not 80)
%}
N_trainingWindows = round(trainingPercentage * length(FEATURES));

train_idx = randperm(size(FEATURES,1), N_trainingWindows);
test_idx = ~ismember([1:size(FEATURES,1)], train_idx);

trainingFeatures = FEATURES(train_idx, :);  % 80% of the feature matrix
trainingLabels = LABELS(train_idx);             % 80% of label matrix

testingFeatures = FEATURES(test_idx,:);   % 20% of the feature matrix
testingLabels = LABELS(test_idx);             % 20% of label matrix


end