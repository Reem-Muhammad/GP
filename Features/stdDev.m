function [ stdDev_avg ] = stdDev( data, windowSize )
%{
Calculates the standard deviation for a record
%}
disp('SD\n');
stdDev_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector
channelsNumber = size(data,2);
for ch = 1:channelsNumber
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize));
    stdD = std(ch_windows)';
    stdDev_avg = stdDev_avg + stdD;
end
stdDev_avg = stdDev_avg ./channelsNumber; %average the feature across all the channels
end

