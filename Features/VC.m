function [ vc_avg ] = VC( window )
%{
This function calculates the variation coefficient of a given window

**inputs**
    window: the epoch for which the variation coefficient is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    vc_avg: the variation coefficient of the given window, averaged across channels
%}


channelsNumber = size(window,2); %number of channels for a given window
vc_avg = 0; %Stores the final value of the feature
vc_channel = 0; %stores the variation coefficient of that window for a certain channel (temporarily)

%loop through channels
for ch = 1: channelsNumber              
    
    vc_channel = varCoeff(window(:, ch)); 
    vc_avg = vc_channel + vc_avg; %summation of the variation coefficient values from all channels
   
end
vc_avg = vc_avg/channelsNumber; %averaging across channels

end

