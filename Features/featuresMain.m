function [ FEATURE_MATRIX ] = featuresMain( )

featureExtraction();
FEATURE_MATRIX = featureMatrix_Construct();

end

