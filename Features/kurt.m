function y=kurt(x) 

X=x;
averageofX=sum(X)/length(X); stdofX=STD(x);
%function called kurt that takes x and return y %where y is the kurtosis values
%to avoid mistakes of capitalization %calculate average
%calculate standard deviation using the %previous implemented STD function
y=sum((((X-averageofX)/stdofX).^4))/length(X); %kurtosis equation

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%STD function implementation module%%%%%%%%%%%%%%%%%%%%%%%%%
function y=STD(x)
averageofX=sum(x)/length(x); y=sqrt(sum(((x-averageofX).*(x-averageofX)))/(length(x)-1));
end