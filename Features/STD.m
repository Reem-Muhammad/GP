function y=STD(x)
averageofX=sum(x)/length(x); 
y=sqrt(sum(((x-averageofX).*(x-averageofX)))/(length(x)-1));
end