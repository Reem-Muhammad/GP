function [ minAbs_avg ] = minAbs( data, windowSize )

%{
Calculates the standard deviation for a record
%}
disp('min Absolute\n');
minAbs_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector
channelsNumber = size(data,2);
for ch = 1:channelsNumber
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize));
    minAb = min(abs(ch_windows))';
    minAbs_avg = minAbs_avg + minAb;
end
minAbs_avg = minAbs_avg ./channelsNumber; %average the feature across all the channels

end

