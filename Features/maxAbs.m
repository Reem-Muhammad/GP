function [ maxAbs_avg ] = maxAbs( data, windowSize )

%{
Calculates the standard deviation for a record
%}
disp('max Absolute\n');
maxAbs_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector
channelsNumber = size(data,2);
for ch = 1:channelsNumber
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize));
    maxAb = max(abs(ch_windows))';
    maxAbs_avg = maxAbs_avg + maxAb;
end
maxAbs_avg = maxAbs_avg ./channelsNumber; %average the feature across all the channels

end

