function [ kurt_avg ] = kurt( window)
%{
This function calculates the kurtosis of a given window

**inputs**
    window: the epoch for which the kurtosis is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    kurt_avg: the kurtosis of the given window, averaged across channels
%}

kurt_avg = 0; %Stores the final kurtosis value of the window
kurt_channel = 0; %stores the kurtosis of that window for a certain channel (temporarily)
channelsNumber = size(data,2);

%loop through channels
for ch = 1: channelsNumber              
     
   kurt_channel = kurtosis(window(:, ch)); 
   kurt_avg = kurt_channel + kurt_avg; %summation of kurtosis values from all channels
   
end
kurt_avg = kurt_avg/channelsNumber; %averaging across channels

end

