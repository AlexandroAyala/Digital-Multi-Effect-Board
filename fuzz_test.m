clc;
clear all;

% read the sample waveform
[signal,samplerate] = audioread('Little.wav');

gain = 10;
mix = 1; 

q=signal*gain/max(abs(signal));
z=sign(-q).*(1-exp(sign(-q).*q));
y=mix*z*max(abs(signal))/max(abs(z))+(1-mix)*signal;
y=y*max(abs(signal))/max(abs(y));

% write output
audiowrite('out_fuzz.wav', y, samplerate);

figure(1);
hold on
plot(y,'r');
plot(signal,'b');
title('Fuzz Signal');

