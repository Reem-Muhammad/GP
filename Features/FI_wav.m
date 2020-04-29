function [ fid3_avg, fid4_avg, fid5_avg ] = FI_wav( data, windowSize )

fid3_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector (feature averaged across all channels)
fid4_avg = zeros(floor(length(data)/windowSize),1);
fid5_avg = zeros(floor(length(data)/windowSize),1);

channelsNumber = size(data,2);

fid3 = zeros(floor(length(data)/windowSize), channelsNumber); %to store the feature of each window for all channels (no.windows per ch * no. channels)
fid4 = zeros(floor(length(data)/windowSize), channelsNumber);
fid5 = zeros(floor(length(data)/windowSize), channelsNumber);

for ch = (1: channelsNumber)*3              
    ch_windows = reshape(data(:,ch), windowSize, floor(length(data)/windowSize));  
    %extract the the number of windows per channel
    N_windows = size(ch_windows, 2);
    
    %loop through the windows of each channel
    for window_iter = 1:N_windows    
        %extract a window (column) to be processed
        ProcessedWindow = ch_windows(:,window_iter);     
        %concatenate FD values of the windows  
        output = fluctuationIdx_wav(ProcessedWindow);
        fid3(window_iter, ch)= output(1);
        fid4(window_iter, ch)= output(2);
        fid5(window_iter, ch)= output(3);
    end
   fid3_avg = mean(fid3, 2);
   fid4_avg = mean(fid4, 2);
   fid5_avg = mean(fid5, 2);
end

end

