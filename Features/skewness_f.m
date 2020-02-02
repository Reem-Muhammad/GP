function skew_output = skewness_f[surrogate_channel, windowSize]
windows = reshape(surrogate_channel, windowSize, floor(length(surrogate_channel)/windowSize));
skew_output = skewness(windows);
end