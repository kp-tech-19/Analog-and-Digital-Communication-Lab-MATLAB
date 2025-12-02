clc; clear; close all;
% 1 Basic Parameters 
Tb = 1;fs = 100;fc = 5;t = 0:1/fs:Tb-1/fs;
b = [1 0 1 1 0 1 0 0];N = length(b);
% 2 Make sure bit count is even
if mod(N,2) ~= 0
    b = [b 0];
end
% 3 Bipolar conversion: 0 -> -1, 1 -> +1
b_polar = 2*b - 1;
% 4 Separate into I and Q
a1 = b_polar(1:2:end);     
a2 = b_polar(2:2:end);     
% 5 QPSK Modulation
qpsk = [];
for k = 1:length(a1)
    s = a1(k)*cos(2*pi*fc*t) + a2(k)*sin(2*pi*fc*t);
    qpsk = [qpsk s];
end
t_total = 0:1/fs:(length(a1)*Tb)-1/fs;
%6 plot
figure;
subplot(4,1,1);stairs(0:N-1, b, 'LineWidth', 2);
ylim([-0.2 1.2]);title('Input Bitstream');xlabel('Bit Index'); ylabel('Bit Value');
subplot(4,1,2);stairs(a1, 'LineWidth', 2);
ylim([-1.5 1.5]);title('I Channel Bits');xlabel('Symbol Index'); ylabel('Amplitude');
subplot(4,1,3);stairs(a2, 'LineWidth', 2);
ylim([-1.5 1.5]);title('Q Channel Bits');xlabel('Symbol Index'); ylabel('Amplitude');
subplot(4,1,4);plot(t_total, qpsk, 'LineWidth', 1.5);
title('QPSK Modulated Signal');xlabel('Time (s)'); ylabel('Amplitude');
