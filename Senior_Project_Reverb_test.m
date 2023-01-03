clc;
clear all;
%Reverb Simulation
[signal, samplerate1] = audioread('Little.wav'); %recorded on audacity
signal = signal';
[IR, samplerate2] = audioread('s1r2.wav'); %downloaded from https://www.openair.hosted.york.ac.uk/?page_id=425
IR = IR';
stepsize = 1/samplerate1;
%the sample rate chosen was 96kHz just because that is the sample rate of
%the impulse resonses from the site above
x = 0:stepsize:(length(signal)-1)*stepsize;
h = 0:stepsize:(length(IR)-1)*stepsize;
sig_length = length(signal);
if mod(sig_length,2) == 0    % if we are dealing with an EVEN number of elements in FFT
    endIndex = (sig_length/2)+1;   % using appropriate formula from class to determine last positive frequency index (for EVEN case)
else
    endIndex = ceil(sig_length/2); % using appropriate formula from class to determine last positive frequency index (for ODD case)
end
index = 1:1:endIndex;
endTime = (length(x) + length(h)-2)*stepsize;
period = endTime;
freq_x = index/period;
reverb_length = length(signal) + length(IR) - 1;
%extended the size of both wavefiles so they match and i can do fft
sig_fft = fft(signal, reverb_length);
sig_fft = sig_fft / sig_length*period;

h_fft = fft(IR, reverb_length);
h_fft = h_fft /sig_length*period;

new_sig = sig_fft .* h_fft;
new_sig = ifft(new_sig);

new_sig = new_sig/max(abs(new_sig));

audiowrite('cathedral_reverb.wav', new_sig, samplerate1);
