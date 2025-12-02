clc; close all; clear;

% Parameters 
Vmax = 4;
n = 3;
fm = 70;
fs = 2000;

% Signal 
t = 0:1/fs:1/fm;
x = Vmax*sin(2*pi*fm*t);

% Quantization  
L = 2^n;
Vmin = -Vmax;
stepsize = (Vmax - Vmin)/L;
q = Vmin:stepsize:Vmax;
c = Vmin - stepsize/2 : stepsize : Vmax + stepsize/2;
[index, q1] = quantiz(x, q, c);

% Binary representation 
T = de2bi(index, 'left-msb');
S = reshape(T', [1 numel(T)]);
t2 = linspace(0, max(t), length(S));

% --- PLOTS --- 
figure;

subplot(221);
plot(t, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(222);
stem(t, x);
title('Original Signal (Stem)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(223);
stairs(t, q1); hold on;
plot(t, x, '--');
title('Quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Quantized','Original');

subplot(224);
stairs(t2, S);
title('Binary Sequence');
xlabel('Time (s)');
ylabel('Bit Value');
ylim([-0.1 1.1]); 
