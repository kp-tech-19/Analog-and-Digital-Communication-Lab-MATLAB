clc; clear; close all;
% 1 Parameters 
Tb = 1;fs = 100;fc = 5;t = 0:1/fs:Tb-1/fs;      
% 2 Generate random bits
b = randi([0 1], 1, 32);N = length(b);  
% 3 Group bits into 4 for 16-QAM
b4 = reshape(b, 4, []).';     
% 4 Mapping function: 00→-3 , 01→-1 , 11→+3 , 10→+1
map = @(x) 2*bi2de(x,'left-msb') - 3;
% 5 I and Q bits
I_bits = b4(:,1:2);Q_bits = b4(:,3:4);
% 6 Convert to amplitudes
I = map(I_bits);Q = map(Q_bits);
% 7 Normalize average power
norm_factor = sqrt(mean(I.^2 + Q.^2));
I = I / norm_factor;Q = Q / norm_factor;
% 8 QAM modulation
qam = [];
for k = 1:length(I)
    s = I(k)*cos(2*pi*fc*t) + Q(k)*sin(2*pi*fc*t);
    qam = [qam s];
end
t_total = 0:1/fs:(length(I)*Tb)-1/fs;
%9 plot
figure;
subplot(4,1,1);stairs(0:N-1, b, 'LineWidth', 2);
ylim([-0.2 1.2]);title('Input Bitstream');xlabel('Bit Index'); ylabel('Bit Value');
subplot(4,1,2);stairs(I, 'LineWidth', 2);
ylim([-1.5 1.5]);title('I Channel Amplitudes');xlabel('Symbol Index'); ylabel('I Amplitude');
subplot(4,1,3);stairs(Q, 'LineWidth', 2);
ylim([-1.5 1.5]);title('Q Channel Amplitudes');xlabel('Symbol Index'); ylabel('Q Amplitude');
subplot(4,1,4);plot(t_total, qam, 'LineWidth', 1.5);
title('16-QAM Modulated Signal');xlabel('Time (s)'); ylabel('Amplitude');
