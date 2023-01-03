clc;
clear all;

[signal, samplerate1] = audioread('Little.wav'); %trying out different tracks
%the samplerate is something i am going to have to experiement with later
%read the sample waveform
outfile = 'flanger.wav';
% parameters to vary the effect. will require fine tuning so that it does
% not turn into other delay effects types like the chorus effect or reverb

maxdelay=0.003; % 3-10ms max delay in seconds at 10ms it is very pitch 
%shifted or "detuned" 
%sounds more wobbly with no detune at lower delay
%masdelay would also be what i would make a paramater later for the user to
%change
rate=1; %rate of flange in Hz
index=1:length(signal);
% sin reference to create oscillating delay
sin_ref = (sin(2*pi*index*(rate/samplerate1)))';    % sin(2pi*fa/fs);


maxsampledelay=round(maxdelay*samplerate1); %convert delay in ms to max delay in samples
y = zeros(length(signal),1);       
y(1:maxsampledelay)=signal(1:maxsampledelay); % to avoid referencing of negative samples
amp=0.7; % suggested coefficient from page 71 DAFX
% for each sample
for i = (maxsampledelay+1):length(signal)
    cur_sin=abs(sin_ref(i));    %abs of current sin val 0-1
    cur_delay=ceil(cur_sin*maxsampledelay);  % generate delay from 1-max_samp_delay and ensure whole number  
    y(i) = (amp*signal(i)) + amp*(signal(i-cur_delay));   % add delayed sample
end
% write output
audiowrite(outfile, y, samplerate1);
figure(1)
hold on
plot(signal,'r');
plot(y,'b');
title('Flanger and original Signal');