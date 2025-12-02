clc; clear; close all;
% ---- 1 Parameters ----
M = input('Enter M (2=BPSK, 4=QPSK, 8=8-PSK): ');
N = 1e5;SNR_dB = -4:10;k=log2(M);         
% ----2 Generate random data and modulate ----
data = randi([0 M-1], N, 1); 
tx = pskmod(data, M);   
% ---- 3 Initialize BER arrays ----
ber_sim = zeros(size(SNR_dB));
ber_theory = zeros(size(SNR_dB));
% ---- 4 FINDING ----
for i = 1:length(SNR_dB)
    % 1 Add noise and demodulate
    rx = awgn(tx, SNR_dB(i), 'measured'); 
    rx_data = pskdemod(rx, M);          
    % 2 Compute simulated BER
    [~, ber_sim(i)] = biterr(de2bi(data,k), de2bi(rx_data,k));
    % 3Compute theoretical BER
    EbN0 = 10^(SNR_dB(i)/10);
    if M==2
        ber_theory(i) = qfunc(sqrt(2*EbN0));  % BPSK
    else
        ber_theory(i) = (2/k) * qfunc(sqrt(2*k*EbN0)*sin(pi/M)); % M-PSK
    end
end
% ---- 5 Plot ----
semilogy(SNR_dB, ber_sim,'ro-','LineWidth',1.5); hold on;
semilogy(SNR_dB, ber_theory,'b-','LineWidth',1.5); grid on;
xlabel('SNR (dB)'); ylabel('Bit Error Rate');title('BER ANALYSIS');legend('Simulated','Theoretical');
