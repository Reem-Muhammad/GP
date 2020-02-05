function [ featureMatrix_record ] = featureMatrix_Construct( surrogate_channel )

addpath('./Features');
featureMatrix_record = [kurtosis_f(surrogate_channel) skewness(surrogate_channel) spectralCentroid(surrogate_channel) spectralSkew(surrogate_channel) variationCoefficient(surrogate_channel)];

end