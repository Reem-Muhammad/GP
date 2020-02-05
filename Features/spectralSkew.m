function spectralSkew_epochs = spectralSkew[PSD_epochs, SC_epochs, VC_epochs]

w = ( (256/(2*size(PSD_epochs,2))) * [1:size(PSD_epochs,2)] );
for epoch = 1:length(PSD_epochs)
    spectralSkew_epochs(epoch, :) = sum(( ( (w-SC_epochs(epoch)) /VC_epochs ).^3).*PSD_epochs(epoch, : ))/ sum(PSD_epochs(epoch, : ));
end

end