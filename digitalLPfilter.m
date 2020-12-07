clc;
clear;

tic;
wp = 0.25*pi; %normalised passband frequency in rad/s
ws = 0.55*pi; %normalised stopband frequency in rad/s
Rp = 0.5; %passband attenuation in dB
Rs = 15; %stopband attenuaiton in dB

% Step 1: Prewarping
fprintf("\nStep 1: Prewarping\n");
[Wpc, Wsc] = prewarp(wp, ws);
fprintf("====================================================================");

%Step 2: LP prototype
fprintf("\nStep 2: LP prototype specs\n");
fprintf("Not needed cause already in LP\n");
Wp = Wpc;
Ws = Wsc;
fprintf("====================================================================");

%Step 3:Analog LP Prototype filter design
fprintf("\nStep 3: Analog LP Prototype filter design\n");
fprintf("Butterworth filter design:\n");
[B, A] = analogButterworthParams(Wp, Ws, Rp, Rs); %CAREFUL: ensure passband or stopband specs in the file
fprintf("====================================================================");

%Step 4
fprintf("\nStep 4: Convert LP Prototype specs to Desired Filter Specs\n");
fprintf("Not needed because already in LP");
num = B; den = A;
Hd = tf(num, den);
display(Hd);
% display(num);
% display(den);
fprintf("====================================================================");

%Step 5
fprintf("\nStep 5: Convert analog filter specs to digital\n");
[numd, dend] = bilinear(num, den, 0.5); %fs is taken as 0.5 since we always assume T = 2 for simplicity
fprintf("CAUTION: Use z in place of s, now that you're in the digital domain\n");
Gd = tf(numd, dend, 0.5);
display(Gd);

%measuring elapsed times
fprintf("*********************************\n");
toc;
fprintf("*********************************\n");
