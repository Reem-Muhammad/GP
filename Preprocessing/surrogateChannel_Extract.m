%function surrogateChannel = surrogateChannel_Extract(data, header)

horizon = 30*60*256; %horizon in no. samples
preictal_start = (header.annotation.starttime*256)-horizon;
preictal_signal =data;
interictal_signal = data;
if preictal_start < 0 
    preictal_signal(header.annotation.endtime*256:end, :) = 0;
    interictal_signal ( 1 : header.annotation.starttime*256, :) = 0;
else
    preictal_signal( preictal_start : header.annotation.starttime*256, :) = 0;
    interictal_signal( (header.annotation.starttime*256)+1 : end, :) = 0;
end

[W, lambda, A] = csp(preictal_signal', interictal_signal');
surrogate_space = W' * data';
surrogate_channel = surrogate_space(find(lambda == max(lambda),1), : );

%%%Visualization%%%
subplot(2,1,1);
scatter(surrogate_channel(1:90000),surrogate_channel(110000:110000+90000-1));
ylabel('preictal');
xlabel('interictal');
title('Surrogate Channel');

subplot(2,1,2);
scatter(data(1:90000, 2),data(110000:110000+90000-1 ,2));
ylabel('preictal');
xlabel('interictal');
title('Channel 2');