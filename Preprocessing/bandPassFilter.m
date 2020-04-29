function [ filtered_data ] = bandPassFilter( data , Fcl, Fcu, Fs )

%{
Stage 2 of preprocessing:

Takes the data after removing bad channels, and returns the data after
applying a band-pass filter

data: record after removing bad channels
Fcl: lower cutoff frequency
Fcu: upper cutoff frequency
Fs: sampling frequency of the record (256 Hz for CHB-MIT dataset)

%}

%design the filter
bandPassFilter = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', Fcl, Fcl+1, Fcu, Fcu+5, 50, 1, 50, Fs);
bandPassFilter_design = design(bandPassFilter, 'equiripple');
%fvtool(bandPassFilter_design); %to plot the filter response

%apply the filter to the record
filtered_data= filter(bandPassFilter_design, data);
%f = Fs*(0:(length(data)-1))/length(data);
%plot(f, abs(fft(filtered_data(:,1)))); %to plot the signal after
%filteration


end

