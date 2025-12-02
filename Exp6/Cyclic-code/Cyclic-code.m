clc; clear; close all;
disp("CYCLIC CODE (7,4) ");
% 1 Generator polynomial g(x) = 1 + x + x^3  → [1 0 1 1]
g = [1 0 1 1];n = 7; k = 4;
% ----2 Input Message ----
msg = input("Enter 4 message bits (e.g. [1 0 1 1]): ");
if length(msg) ~= k
    error("Message must be exactly 4 bits");
end
% ---- 3 Append 3 zeros (n-k = 3) ----
msg_padded = [msg 0 0 0];
% ---- 4 xor ----
temp = msg_padded;
for i = 1:k
    if temp(i) == 1
        temp(i:i+3) = xor(temp(i:i+3), g);
    end
end
% ---- 5: parity (remainder) ----
parity = temp(k+1:n);
% ---- 6: codeword ----
codeword = [msg parity];
% ---- 7 Output ----
disp("Message bits: ");disp(msg);
disp("Parity bits: ");disp(parity);
disp("Cyclic Code Output (7,4): ");disp(codeword);
