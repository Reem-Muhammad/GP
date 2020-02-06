function [ featureMatrix_record ] = featureMatrix_Construct( combinedIMF, N)

addpath('.\Features');
addpath('..\preprocessing')
% featureMatrix_record = [average(surrogate_channel, N)', kurtosis_f(surrogate_channel, N)', skewness(surrogate_channel, N)', spectralCentroid(surrogate_channel, N)', spectralSkew(surrogate_channel, N)', standardDeviation(surrogate_channel, N)', variationCoefficient(surrogate_channel, N)'];
%psd = PSD(surrogate_channel);
% .........
%.........
%.........
featureMatrix_record = [average(combinedIMF, N)', kurtosis_f(combinedIMF, N)', skewness_f(combinedIMF, N)', standardDeviation(combinedIMF, N)' FD_F(combinedIMF, N)'];

end