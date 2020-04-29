function [ processedWindow ] = preprocessingMain( window )
%{
This is the main function that abstracts the preprocessing.

**inputs**
    window: epoch to be processed

**outputs**
    processedWindow: epoch after removing NaN channels, and filtering.
%}

%removing NaN channels
cleanWindow = badChannels_Remove(window);
%filtering the data
processedWindow = notchFilter(cleanWindow);

end