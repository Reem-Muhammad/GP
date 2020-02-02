function IMFs = Decompose[surrogate_channel]

maxima = findpeaks(surrogate_channel);
minima = findpeaks(-surrogate_channel);

end