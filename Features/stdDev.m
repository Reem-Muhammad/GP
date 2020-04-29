function [ stdDev_avg ] = stdDev( window )
%{
This function calculates the standard deviation of a given window

**inputs**
    window: the epoch for which the standard deviation is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    stdDev_avg: the standard deviation of the given window, averaged across channels
%}


channelsNumber = size(window,2); %number of channels for a given window
stdDev_avg = 0; %Stores the final value of the feature
stdDev_channel = 0; %stores the standard deviation of that window for a certain channel (temporarily)

%loop through channels
for ch = 1: channelsNumber              
     
   stdDev_channel = std(window(:, ch)); 
   stdDev_avg = stdDev_channel + stdDev_avg; %summation of the standard deviation values from all channels
   
end
stdDev_avg = stdDev_avg/channelsNumber; %averaging across channels
end

