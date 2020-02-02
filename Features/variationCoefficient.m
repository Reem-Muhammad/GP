function VC_epochs = variationCoefficient[PSD_epochs, SC_epochs]

VC_epochs = zeros(length(PSD_epochs), 1);
w = ( (256/(2*size(PSD_epochs,2))) * [1:size(PSD_epochs,2)] );
for epoch = 1:length(PSD_epochs)
    VC_epochs(epoch, :) = sum(((w-SC_epochs(epoch)).^2).*PSD_epochs(epoch, : ))/ sum(PSD_epochs(epoch, : ));
end

end