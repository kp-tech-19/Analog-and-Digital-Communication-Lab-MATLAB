clc; clear; close all;
N = 1000; SNR_low = 24; SNR_high = -9;
% BPSK
data = randi([0 1], N, 1);bpsk_symbols = 2*data - 1;
figure;
subplot(1,3,1); scatter(bpsk_symbols, zeros(size(bpsk_symbols)), 50, 'filled'); title('BPSK - Ideal'); axis([-2 2 -2 2]); grid on;
subplot(1,3,2); scatter(real(awgn(bpsk_symbols,SNR_low,'measured')), imag(awgn(bpsk_symbols,SNR_low,'measured')), 50,'filled'); title('BPSK - Low Noise'); axis([-2 2 -2 2]); grid on;
subplot(1,3,3); scatter(real(awgn(bpsk_symbols,SNR_high,'measured')), imag(awgn(bpsk_symbols,SNR_high,'measured')), 50,'filled'); title('BPSK - High Noise'); axis([-2 2 -2 2]); grid on;
% QPSK
data = randi([0 3], N, 1);
qpsk_symbols = pskmod(data,4,pi/4);
figure;
subplot(1,3,1); scatter(real(qpsk_symbols), imag(qpsk_symbols), 50, 'filled'); title('QPSK - Ideal'); axis([-2 2 -2 2]); grid on;
subplot(1,3,2); scatter(real(awgn(qpsk_symbols,SNR_low,'measured')), imag(awgn(qpsk_symbols,SNR_low,'measured')),50,'filled'); title('QPSK - Low Noise'); axis([-2 2 -2 2]); grid on;
subplot(1,3,3); scatter(real(awgn(qpsk_symbols,SNR_high,'measured')), imag(awgn(qpsk_symbols,SNR_high,'measured')),50,'filled'); title('QPSK - High Noise'); axis([-2 2 -2 2]); grid on;
% 16-QAM
data = randi([0 15], N, 1);
qam_symbols = qammod(data, 16);
figure;
subplot(1,3,1); scatter(real(qam_symbols), imag(qam_symbols), 50,'filled'); title('16-QAM - Ideal'); axis([-5 5 -5 5]); grid on;
subplot(1,3,2); scatter(real(awgn(qam_symbols,SNR_low,'measured')), imag(awgn(qam_symbols,SNR_low,'measured')), 50,'filled'); title('16-QAM - Low Noise'); axis([-5 5 -5 5]); grid on;
subplot(1,3,3); scatter(real(awgn(qam_symbols,SNR_high,'measured')), imag(awgn(qam_symbols,SNR_high,'measured')),50,'filled'); title('16-QAM - High Noise'); axis([-5 5 -5 5]); grid on;
