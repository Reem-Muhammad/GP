function [ FI_D3, FI_D4, FI_D5 ] = fluctuationIdx_wav( window )
 
%decompose the window into approximation and detail coefficients
[C,L] = wavedec(window,5,'db4');

%extract the detail coefficients d3, d4, d5 for each window
[d1,d2,d3,d4,d5] = detcoef(C,L,[1,2,3,4,5]);

%----------calculate FI for each level------------- 
FI_D3 = mean(abs([d3(2:end); 0] - d3));
FI_D4 = mean(abs([d4(2:end); 0] - d4));
FI_D5 = mean(abs([d5(2:end); 0] - d5));
%-------------------------------------------

end

