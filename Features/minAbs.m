function [ minAbs_avg ] = minAbs( window )
%{
This function calculates the max absolute of a given window

**inputs**
    window: the epoch for which the min absolute is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    maxAbs_avg: the min absolute of the given window, averaged across channels
%}


channelsNumber = size(window,2); %number of channels for a given window
minAbs_avg = 0; %Stores the final min absolute value of the window
minAbs_channel = 0; %stores the min absolute of that window for a certain channel (temporarily)

%loop through channels
for ch = 1: channelsNumber              
     
   minAbs_channel = min(abs(window(:, ch))); 
   minAbs_avg = minAbs_channel + minAbs_avg; %summation of the min absolute values from all channels
   
end
minAbs_avg = minAbs_avg/channelsNumber; %averaging across channels

end

