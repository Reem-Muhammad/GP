function [ he_avg ] = hurstExp( data, windowSize )
disp('Hurst\n');
he_avg = zeros(floor(length(data)/windowSize),1); %initialize the output vector (feature averaged across all channels)
channelsNumber = size(data,2);
he = zeros(floor(length(data)/windowSize), channelsNumber); %to store the feature of each window for all channels (no.windows per ch * no. channels)

for ch = 1: channelsNumber              
    ch_windows = reshape(data(1:floor(length(data)/windowSize)*windowSize,ch),windowSize, floor(length(data)/windowSize)); 
    %extract the the number of windows per channel
    N_windows = size(ch_windows, 2);
    
    %loop through the windows of each channel
    for window_iter = 1:N_windows    
        %extract a window (column) to be processed
        ProcessedWindow = ch_windows(:,window_iter);     
        %concatenate values of the windows  
        he(window_iter, ch)= genhurst(ProcessedWindow);
    end
   he_avg = mean(he, 2); 
end
end

