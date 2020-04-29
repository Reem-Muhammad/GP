function [ skew_avg ] = skew( data, windowSize )
%{
Calculates the skewness for a record
%}
disp('Skewness\n');
skew_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector
channelsNumber = size(data,2);

%loop throught the channels to evaluate the feature for its windows
for ch = 1:channelsNumber
    %rearrange the time samples into windows (no. samples in a window * no. windows)
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize));
    %evaluate the feature for each window
    sk = skewness(ch_windows)';
    %sum the values of the feature across all channels, for later averaging
    skew_avg = skew_avg + sk;
end
skew_avg = skew_avg ./channelsNumber; %average the feature across all the channels
end

