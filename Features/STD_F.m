function [ STD_outputMatrix ] = STD_F( data )

[n_samples, n_channels] = size(data); %obtain the dimensions of the record
windowSize = 1024; %equivalent to 4 seconds

%%%%%%STD_outputMatrix = []; %stores the std values of all channels. each row has the std values of the windows of a single channel
STD_outputMatrix = zeros(n_channels, floor(n_samples/windowSize)); %initialize the output matrix %--------<

disp('Feature:');
disp('Standard Deviation');

%loop through the channels
for ch=1:n_channels
    
    disp('channel_No:');
    disp(ch);
    
    channel = data(1: floor(n_samples/windowSize)*windowSize, ch);%contains all the samples of a selected channel
    
    
    %%%%STD_vector_window = []; %initialize the vector before processing each channel
    
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
            
            %evaluate the standard deviation
            std = STD(ProcessedWindow);
            %%%%%STD_vector_window = [STD_vector_window std]
            STD_outputMatrix(ch, window_iter)= std; 
        end
      %%%%%%STD_outputMatrix = [STD_outputMatrix; STD_vector_window];  
end


end

