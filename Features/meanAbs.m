function [ meanAbs_avg ] = meanAbs( data, windowSize )

%{
Calculates the standard deviation for a record
%}
disp('mean Absolute\n');
meanAbs_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector
channelsNumber = size(data,2);
for ch = 1:channelsNumber
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize));
    stdDev = mad(ch_windows)';
    meanAbs_avg = meanAbs_avg + stdDev;
end
meanAbs_avg = meanAbs_avg ./channelsNumber; %average the feature across all the channels

end

