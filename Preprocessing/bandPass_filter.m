function [ processed_data ] = bandPass_filter( data , Fcl, Fcu, Fs )

%{
data: EEG record
Fcl: lower cutoff frequency
Fcu: upper cutoff frequency
Fs: sampling frequency of the record (256 Hz for CHB-MIT dataset)
%}

%design the filter
bandPassFilter = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', Fcl, Fcl+1, Fcu, Fcu+1, 50, 1, 50, Fs);
bandPassFilter_design = design(bandPassFilter, 'equiripple');
%fvtool(bandPassFilter_design); %to plot the filter response

%apply the filter to the record
processed_data= filter(bandPassFilter_design, data);


end

