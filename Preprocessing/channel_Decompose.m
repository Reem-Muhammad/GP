function combinedIMF = channel_Decompose(surrogate_channel)

IMF = emd(surrogate_channel, 'MAXMODES', 8);
%extract the last 4 IMFs (the last row is the residue, so it's excluded)
significantIMFs = IMF(end-4:end-1, :);
%combine them
combinedIMF = sum(significantIMFs, 1);

end