function [ maxAbs_avg ] = maxAbs( window)
%{
This function calculates the max absolute of a given window

**inputs**
    window: the epoch for which the max absolute is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    maxAbs_avg: the max absolute of the given window, averaged across channels
%}


channelsNumber = size(window,2); %number of channels for a given window
maxAbs_avg = 0; %Stores the final max absolute value of the window
maxAbs_channel = 0; %stores the max absolute of that window for a certain channel (temporarily)

%loop through channels
for ch = 1: channelsNumber              
     
   maxAbs_channel = max(abs(window(:, ch))); 
   maxAbs_avg = maxAbs_channel + maxAbs_avg; %summation of the max absolute values from all channels
end
maxAbs_avg = maxAbs_avg/channelsNumber; %averaging across channels


end