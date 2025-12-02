clc; clear; close all;
% --- 1.Parameters  ---
bits = [1 0 1 1 0 0 1 0];Tb = 1;spb = 100; 
N = length(bits);t = linspace(0, N*Tb, N*spb);  
A = 5;f1 = 3;f2 = 5;noiseAmp = 10; 
% --- 2.NRZ (bipolar) ---
NRZ = repelem(2*bits - 1, spb);
% --- 3.Carrier Signal ---
fc = 5;carrier = sqrt(2/Tb) * cos(2*pi*fc*t);
% --- 4.BFSK Modulation ---
modulated = A * sin(2*pi*f1*t).*(NRZ==-1) + A * sin(2*pi*f2*t).*(NRZ==1);
% --- 5.Add Noise ---
rx = modulated + noiseAmp * randn(size(modulated));
% --- 6.Coherent Demodulation ---
demod1 = rx .* sin(2*pi*f1*t);  
demod2 = rx .* sin(2*pi*f2*t);  
% --- 7.Integrate  ---
y1 = zeros(1, N);
y2 = zeros(1, N);
for k = 1:N
    idx = (k-1)*spb + 1 : k*spb;    
    y1(k) = trapz(t(idx), demod1(idx));
    y2(k) = trapz(t(idx), demod2(idx));
end
received = y2 > y1;  
% --- 8.LPF Example (Optional, like BPSK) ---
bfsk = NRZ .* carrier;
bfsk_noisy = bfsk + noiseAmp * randn(size(bfsk));
filtered = conv(bfsk_noisy .* carrier, ones(1, spb)/spb, 'same');
% --- 9.PLOTS ---
figure('Name','BFSK Experiment','NumberTitle','off');
subplot(7,1,1); stairs(0:N-1, bits,'LineWidth',1.5); title('Original Bits'); xlim([0 N]);
subplot(7,1,2); plot(t, sin(2*pi*f1*t)); title('Carrier f1'); xlim([0 N]);
subplot(7,1,3); plot(t, sin(2*pi*f2*t)); title('Carrier f2'); xlim([0 N]);
subplot(7,1,4); plot(t, modulated); title('BFSK Modulated'); xlim([0 N]);
subplot(7,1,5); plot(t, rx); title('BFSK with noise'); xlim([0 N]);
subplot(7,1,6); plot(t, filtered); hold on; yline(0,'r--'); title('Correlator + LPF Output'); xlim([0 N]);
subplot(7,1,7); stairs(0:N-1, received,'LineWidth',1.5); title('Demodulated Bits'); xlim([0 N]);
