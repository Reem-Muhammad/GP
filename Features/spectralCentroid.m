function [ Cs ] = spectralCentroid( x )
%{
This function contains the mathematics for calculating the spectral
centroid.
Required for calculating some features (varCoeff, spectralSkew)
%}

w=(((-length(x)+1):1:(length(x)-1)))';    % signal center frequency 
P=abs(fftshift(PSD(x)));   %to find Power spectral Density 
%  size(P)
%  size(w)
S2=sum(w.*P);                 
S1=sum(P);
Cs = S2/S1;  %centroid rule
end