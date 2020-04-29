function [ sc ] = SpecCentroid( window, Fs)
%http://jwilson.coe.uga.edu/emt668/EMT668.Folders.F97/Patterson/EMT%20669/centroid%20of%20quad/Centuse.html

windowFFT = abs(fft(window));
freq = Fs*(0:(length(windowFFT)-1))/length(windowFFT);

sc = sum(freq * windowFFT)/sum(windowFFT);

end

