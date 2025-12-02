clc; clear; close all;
disp('--- (7,4) Linear Block Code ---');
% 1 Generator matrix G (systematic form)
G = [1 0 0 0 1 0 1;
     0 1 0 0 1 1 1;
     0 0 1 0 1 1 0;
     0 0 0 1 0 1 1];
% 2 Input message bits
msg = input('Enter 4 message bits (e.g. [1 0 1 1]): ');
if length(msg) ~= 4
    error('Message must be exactly 4 bits.');
end
% 3 Encode: c = m * G mod 2
coded = mod(msg * G, 2);
disp('Message bits:');disp(msg);
disp('Encoded 7-bit codeword:');disp(coded);
