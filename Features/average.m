function Mean = average(surrogate_channel,windows_Size)

new_data=reshape(surrogate_channel,windows_Size,length(surrogate_channel)/windows_Size); %reshape data 
Mean = mean(new_data);
 end
