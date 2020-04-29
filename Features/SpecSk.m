function [C, CMean, CSD, CMax] = SpecSk(snd,fs,nfft,window,noverlap)
%https://www.audiocontentanalysis.org/code/audio-features/spectral-skewness/
%https://www.mathworks.com/help/audio/ug/spectral-descriptors.html#SpectralDescriptorsExample-3
if(nargin==2)
    nfft = min([length(snd) 2048]);
    window = nfft;
    noverlap = round(window*.8);
    s = spectrogram(snd, nfft, fs, window, noverlap);
elseif (nargin==3)
    s = spectrogram(snd, nfft, fs);
elseif (nargin==4)
    s = spectrogram(snd, nfft, fs, window);
elseif (nargin==5)
    s = spectrogram(snd, nfft, fs, window, noverlap);    
end
C = sum((repmat((1:size(s,1))',1,size(s,2)) .* abs(s))) ./ sum(abs(s));
CMean = mean(C);
CSD = std(C);
CMax = max(C);

%%%%%%sSkew = sum((repmat((1:size(s,1))',1,size(s,2)) .* abs(s))) ./ sum(abs(s));


end
