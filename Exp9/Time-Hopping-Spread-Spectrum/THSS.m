clc; clear; close all;
data = input("Enter data bits [1 0 1 0 1 0 1 0]: ");
data(data==0) = -1;
Fs = 1000; Tb = 0.1;t = 0:1/Fs:Tb;
hop = randi([0 3], 1, length(data)); % 4 time slots
slot = Tb/4;                         % delay per slot
thss = [];
for i = 1:length(data)
    delay = hop(i)*slot;
    t_shift = t + delay;
    thss = [thss data(i) * sin(2*pi*2000*t_shift)];
end
figure;
subplot(3,1,1); stairs(data); title("Input Data");
subplot(3,1,2); stairs(hop); title("Time Hop Pattern");
subplot(3,1,3); plot(thss); title("THSS Signal");
