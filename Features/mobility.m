function [ mob ] = mobility( window )
%calculates the mobility:
%defined as the square root of variance of the first derivative of the signal divided by variance of the signal
firstDerivative = diff([0;window]);
mob = sqrt( (var(firstDerivative)/var(window)) );

end

