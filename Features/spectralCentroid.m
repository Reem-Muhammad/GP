function SC_epochs = spectralCentroid[PSD_epochs]
SC_epochs = zeros(length(PSD_epochs), 1);
%w = [0:size(PSD_epochs,2)-1];
w = ( (256/(2*size(PSD_epochs,2))) * [1:size(PSD_epochs,2)] );

%loop through the epochs
for epoch = 1:length(PSD_epochs)
    SC_epochs(epoch, :) = sum(w.*PSD_epochs(epoch, : ))/ sum(PSD_epochs(epoch, : ));
end

end