function [ kurt_outputMatrix ] = kurt_F( data )

[n_samples, n_channels] = size(data); %obtain the dimensions of the record
windowSize = 1024; %equivalent to 4 seconds
k = 128; %number of new sub-sets to be constructed 
%%%%%%%kurt_outputMatrix = []; %stores the FD values of all channels. each row has the FD values of the windows of a single channel
FD_outputMatrix = zeros(n_channels, floor(n_samples/windowSize)); %initialize the output matrix %--------<

disp('Feature:');
disp('Kurtosis');

%loop through the channels
for ch=1:n_channels
    
    disp('channel_No:');
    disp(ch);
    
    channel = data(1: floor(n_samples/windowSize)*windowSize, ch);%contains all the samples of a selected channel
    
    kurt_vector_window = []; %initialize the vector before processing each channel
    
    %reshape the selected channel into windows, where each window is stored
    %in a separate column:
    % window1   | window2   | window3 ...
    %-----------|-----------|------------
    % sample1_1 | sample1_2 | sample1_3 ...
    % sample2_1 | sample2_2 | sample2_3 ...   
    windows = reshape(channel, windowSize, floor(n_samples/windowSize)); 
    
    %extract the number of samples in each window(window_Nrow), and the
    %number of windows per channel (window_Ncol)
    [window_Nrow, window_Ncol] = size(windows);
    
    %loop through the windows of each channel
    for window_iter = 1:window_Ncol
        
        %extract a window (column) to be processed
        ProcessedWindow = windows(:,window_iter); 
        
        %concatenate FD values of the windows 
        %%%%%kurt_vector_window = [kurt_vector_window kurt(ProcessedWindow)] 
        kurt_outputMatrix(ch, window_iter)= kurt(ProcessedWindow); 
    end
    
    %construct the output matrix. each row represents the FD values of all
    %the windows associated with a single channel
    %%%%%%%%kurt_outputMatrix = [kurt_outputMatrix; kurt_vector_window];
end

end

