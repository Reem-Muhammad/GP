function [ rms_avg ] = rootMeanSq( data, windowSize )
%{
Calculates the sroot mean square for a record
%}
disp('RMS\n');
rms_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector
channelsNumber = size(data,2);
for ch = 1:channelsNumber
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize));
    rootMean = rms(ch_windows)';
    rms_avg = rms_avg + rootMean;
end
rms_avg = rms_avg ./channelsNumber; %average the feature across all the channels

end