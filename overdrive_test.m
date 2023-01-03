clc;
clear all;

% read the sample waveform
[signal,sampleRate] = audioread('Little.wav');

N=length(signal);
y=zeros(1,N); % Preallocate y
th=1/3; % threshold for symmetrical soft clipping 
        % by Schetzen Formula
for i=1:N
   if abs(signal(i))< th
       y(i)=2*signal(i);%doubling low amplitude portions of signal
   end
   if abs(signal(i))>=th
      if signal(i)> 0   %boosting positive and negative portions above threshold
          y(i)=(3-(2-signal(i)*3).^2)/3; 
      end
      if signal(i)< 0
          y(i)=-(3-(2-abs(signal(i))*3).^2)/3; 
      end
   end   
   if abs(signal(i))>2*th 
      if signal(i)> 0 
          y(i)=1;%anything above twice the threshold is set to 1 or -1
      end
      if signal(i)< 0
          y(i)=-1;
      end
   end
end
% write output
audiowrite('out_overdrive.wav', y, sampleRate);
figure(1);

hold on
plot(y,'r');
plot(signal,'b');
title('Overdriven Signal');
