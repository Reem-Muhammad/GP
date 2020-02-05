function [Clear_data] = nanremove(data)

[sample,Ch]=size(data); %number of samples
New_data=data(~isnan(data)); %select only data that are not NaN
l=length(New_data);
c=floor(l/sample);
Clear_data=reshape( New_data,sample,c);

end