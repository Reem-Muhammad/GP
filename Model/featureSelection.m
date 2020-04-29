function [ selectedFeatures,  selectedFeatures_idx] = featureSelection( FEATURES, LABELS )
positiveClass = FEATURES(LABELS == 1,:);
negativeClass = FEATURES(LABELS == 0,:);
selectedFeatures_idx = logical(ttest2(positiveClass, negativeClass));
selectedFeatures = FEATURES(:,selectedFeatures_idx);
end

