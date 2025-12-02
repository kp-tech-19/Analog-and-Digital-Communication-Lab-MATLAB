clc; clear; close all;
% --- 1.Parameters ---
bits = [1 0 0 1 0 1 0];    
Tb = 1;spb = 100;N = length(bits);t = linspace(0, N*Tb, N*spb);   
% --- 2.NRZ Conversion (1 → +1, 0 → –1) ---
NRZ = repelem(2*bits - 1, spb);   
% --- 3.Carrier Signal ---
fc = 5;carrier = sqrt(2/Tb) * cos(2*pi*fc*t);
% --- 4.BPSK Modulation ---
bpsk = NRZ .* carrier;
% --- 5.Add Noise ---
noise = 6 * randn(size(bpsk));
rx = bpsk + noise;
% --- 6.Coherent Demodulation ---
mixed = rx .* carrier;            
% 7.Simple Low-pass
lp = ones(1, spb) / spb;
filtered = conv(mixed, lp, 'same');
% --- 8.Decision Device ---
decoded_bits = filtered > 0;      
% --- 9.PLOTS ---
figure('Name','BPSK Experiment','NumberTitle','off');
subplot(5,1,1);
plot(t, NRZ, 'LineWidth', 1.2); ylim([-2 2]);
title('NRZ Line Code');
subplot(5,1,2);
plot(t, bpsk, 'LineWidth', 1.2); ylim([-2 2]);
title('BPSK Modulated Signal');
subplot(5,1,3);
plot(t, rx, 'LineWidth', 0.8); ylim([-2 2]);
title('Received Signal (Noisy)');
subplot(5,1,4);
plot(t, filtered, 'LineWidth', 1); hold on;
yline(0,'r--'); title('Correlator Output + LPF');
subplot(5,1,5);
stairs(decoded_bits,'LineWidth',1.2);
axis([0 length(decoded_bits) -0.5 1.5]);
title('Demodulated Bits');
