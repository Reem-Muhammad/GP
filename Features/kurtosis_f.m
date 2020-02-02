function [ kurtosis_outputMatrix ] = kurtosis_f( surrogate_channel, windowSize )

windows = reshape(surrogate_channel, windowSize, floor(length(surrogate_channel)/windowSize));
kurtosis_outputMatrix = kurtosis(windows);

end

