function [ featuresMatrix ] = featuresMain( window )
%{
This is the main function that abstracts the features.
The function constructs the features matrix.

**inputs**
    window: the epoch from which features are to be extracted (after preprocessing)

**outputs**
    featuresMatrix: the features extracted from the window, combined in a
    single matrix.
%}

featuresMatrix = [stdDev(window), FD(window), hurst(window), kurt(window), spectralSkew(window),...
                    FI(window), maxAbs(window), minAbs(window), VC(window)]; %%%skew or spectral skew??

end

