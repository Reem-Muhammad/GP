function [ FD_vector_window ] = FD_F( combinedIMF, windowSize )


[n_samples, n_channels] = size(combinedIMF); %obtain the dimensions of the record
%windowSize = 1024; %equivalent to 4 seconds
k = 128; %number of new sub-sets to be constructed 
        
    FD_vector_window = []; %initialize the vector before processing each channel
      
    windows = reshape(combinedIMF, windowSize, floor(n_samples/windowSize)); 
    
    %extract the number of samples in each window(window_Nrow), and the
    %number of windows per channel (window_Ncol)
    [window_Nrow, window_Ncol] = size(windows);
    
    %loop through the windows of each channel
    for window_iter = 1:window_Ncol
        
        %extract a window (column) to be processed
        ProcessedWindow = windows(:,window_iter); 
        
        %concatenate FD values of the windows 
        FD_vector_window = [FD_vector_window hfd(ProcessedWindow, k)]; 
         %%%%%%%FD_outputMatrix(ch, window_iter)= hfd(ProcessedWindow, k); 
    end
    
end

