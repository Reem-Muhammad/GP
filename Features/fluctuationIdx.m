function [ fi ] = fluctuationIdx( window )
%{
This function contains the mathematics for calculating FI
%}

abs_between_succsessive=abs([window(2:length(window));0]-window);
fi = sum(abs_between_succsessive);

end

