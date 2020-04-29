function [cleanWindow]=badChannels_Remove(window)
%{
Stage 1 of preprocessing:
The function takes a window, removes NaN channels

**inputs**
    window: epoch to be processed

**output**
    cleanWindow: epoch after removing NaN channels
%}

%~~~~~remove NaN channels~~~~~~%
cleanWindow = window(:,all(~isnan(window)));

 end