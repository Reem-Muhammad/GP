function [ ApEn_outputMatrix ] = ApEn_F( data )
%{
load('G:\MIT_MAT\chb17\chb17a_03'); %loading WS variable

%----------remove NaN channels----------%
%find the indices of the columns (dimension 1) that have only NaN values
nan_columns = find(all(isnan(data),1)); 
%remove the columns
data(:, nan_columns) = [];
%---------------------------------------%
%}
[n_samples, n_channels] = size(data); %obtain the dimensions of the record
windowSize = 1024; %equivalent to 4 seconds

%%%%%%ApEn_outputMatrix = []; %stores the ApEn values of all channels. each row has the ApEn values of the windows of a single channel




ApEn_outputMatrix = zeros(n_channels, floor(n_samples/windowSize)); %initialize the output matrix

disp('Feature:');
disp('Approximate Entropy');

for ch=1:n_channels
    
    disp('channel_No:');
    disp(ch);
    
    channel = data(1: floor(n_samples/windowSize)*windowSize, ch);%contains all the samples of a selected channel
    
      %--- ApEn parameters ---%
        emdeddingDimension = 2; %m
        similarityCriterion =0.15*std(channel);    %r
        timeDelay = 1;
      %-----------------------%
    %%%%ApEn_vector_window = []; %initialize the vector before processing each channel
    
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
            %normalizuing the window
            %ProcessedWindow = abs(ProcessedWindow - mean(ProcessedWindow));
          
            
            %evaluate the approximate entropy for each window
            apen = ApEn(emdeddingDimension, similarityCriterion, ProcessedWindow, timeDelay);
            %apen = approx_entropy(emdeddingDimension, similarityCriterion,
            %ProcessedWindow); %too slow!
            %%%%%%%%%%%%%%%%ApEn_vector_window = [ApEn_vector_window apen]
            ApEn_outputMatrix(ch, window_iter)= apen;
        end
    %%%%%%ApEn_outputMatrix = [ApEn_outputMatrix; ApEn_vector_window];
end