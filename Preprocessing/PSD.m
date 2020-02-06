function PSD_epochs = PSD[combinedIMF, windowSize]

%windowSize = 1 second = 256 sample
windowSize=256;
%convert the signal inot 1-second-long epochs, where each row represents
%one epoch
combinedIMF_epochs = reshape(windowSize, combinedIMF, floor(length(combinedIMF)/windowSize));
PSD_epochs_temp = zeros(length(combinedIMF_epochs), windowSize*2-1); %stores the double-sided FFT
PSD_epochs = zeros(length(combinedIMF_epochs), windowSize); %stores the single-sided FFT
%%%%calculate power spectral density for each epoch by evaluating the fourier transform for the autocorrelation fumction%%%%
%loop through all of the epochs
for epoch = 1:size(combinedIMF_epochs, 1)
    %calculate the autocorrelation for each epoch:
    Rxx = xcorr(combinedIMF_epochs(epoch, : ));
    %calculate PSD
    PSD_epochs_temp(epoch, : ) = abs(fft(Rxx));
    PSD_epochs(epoch, : ) = PSD_epochs_temp(epoch, 1:256);
    %w=((256/2*256)*[1:256])';
    %c=sum(w.*PSD_epochs(epoch, : ))/sum()
end


end