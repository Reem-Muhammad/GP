function [chPreprocess_data]=badChannels_Remove(data, header)
%{
Stage 1 of preprocessing:

The function takes a record, removes the specified bad channels, and
returns the record without NaN and eye channels

data -> the original record in .mat format
header -> the header associated with each record, that contains the names
           of the channels

%}
%~~~~~~~~remove eye channels~~~~~~~%
EOGchannels = {'FP1-F7', 'FP2-F8'}; %specify the channels to be removed
EOGchannels_idx = ismember(header.labels ,EOGchannels); %find their indices
chPreprocess_data = data;
chPreprocess_data(:,EOGchannels_idx)=[]; %remove the channels


%~~~~~remove NaN channels~~~~~~%
chPreprocess_data = chPreprocess_data(:,all(~isnan(chPreprocess_data)));

%end

% EOGchannels_idx = [];
% for EOG_ch = EOGchannels
%     EOGchannels_idx = [EOGchannels_idx, find(ismember(header.labels,EOG_ch))];
 end