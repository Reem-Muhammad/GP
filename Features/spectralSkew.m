function [ y ] = spectralSkew(x)
%{
This function contains the mathematics for calculating the spectral skewness
%}
w=((-length(x)+1):1:(length(x)-1))';
P=abs(fftshift(PSD(x)));
S1 = sum(P);  
S2 = sum( ( (w-spectralCentroid(x)) ./ sqrt(varCoeff(x)) ).^3.*P);

y = S2/S1;


end

