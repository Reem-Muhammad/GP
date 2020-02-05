%data_passing
%================
function STD = standardDeviation(surrogate_channel, windows_Size)
new_data=reshape(surrogate_channel,windows_Size,length(surrogate_channel)/windows_Size); %reshape data 
STD = std(new_data);
end