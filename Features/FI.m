function [ fi_avg ] = FI( window )
%{
This function calculates the FI of a given window

**inputs**
    window: the epoch for which FI is to be calculated. Passed as
    numberOfSamples X numberOfchannels

**outputs**
    fi_avg: the FI of the given window, averaged across channels
%}


channelsNumber = size(window,2); %number of channels for a given window
fi_avg = 0; %Stores the final value of the feature
fi_channel = 0; %stores FI of that window for a certain channel (temporarily)

%loop through channels
for ch = 1: channelsNumber              
     
   fi_channel = fluctuationIdx(window(:, ch)); 
   fi_avg = fi_channel + fi_avg; %summation of the FI values from all channels
   
end
fi_avg = fi_avg/channelsNumber; %averaging across channels

end

