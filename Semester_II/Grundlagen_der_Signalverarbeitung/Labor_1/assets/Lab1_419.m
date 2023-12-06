% Task 4.1.9: Pulse sequences

% Reset
clear all;
close all;
clc;
color_map_1 = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};

% Time range
n = -20:20;

% Function 1 - Dirac impulse
s1 = dirac(n);
s1(s1 == Inf) = 1;

% Function 2 - Jump function (Heaviside)
sympref('HeavisideAtOrigin', 1);
s2 = heaviside(n);

% Function 3
s3(n <= 0) = 0;
s3(n > 0) = n(n > 0);

% Function 4
s4(n <= -2) = -2;
s4(-2 < n & n < 2) = n(-2 < n & n < 2); 
s4(n >= 2) = 2;

signals = {s1, s2, s3, s4};
signal_titles = {'s_1[n] = \delta[n]', 's_2[n] = \sigma[n]', 's_3[n]', 's_4[n]'};

% Plots
tiledlayout("vertical");
for i=1:length(signals)
    nexttile
    stem(n, signals{1,i});
    title([signal_titles(1,i)]);
    grid on
    xlabel('n');
    ylabel('s[n]');
end
set(gcf,'color', [0.95,0.95,0.95]);