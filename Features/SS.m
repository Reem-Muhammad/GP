function [ ss_avg ] = SS( window )
%{
This function calculates the spectral skewness of a given window

**inputs**
    window: the epoch for which the spectral skewness is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    ss_avg: the spectral skewness of the given window, averaged across channels
%}


channelsNumber = size(window,2); %number of channels for a given window
ss_avg = 0; %Stores the final value of the feature
ss_channel = 0; %stores the spectral skewness of that window for a certain channel (temporarily)

%loop through channels
for ch = 1: channelsNumber              
     
   ss_channel = spectralSkew(window(:, ch)); 
   ss_avg = ss_channel + ss_avg; %summation of the spectral skewness values from all channels
   
end
ss_avg = ss_avg/channelsNumber; %averaging across channels
end

