% Task 4.1.6: Parameter of a periodic signal - A

% Reset
clear all;
close all;
clc;
color_map = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};

% Time vector
t = 0:0.05:4.5*pi;

% Function definition
T=2*pi; % Period duration
f=1/T; % Frequency
omega = 2*pi/T; % Circular frequency
s_amp = 1; % Amplitude
s = s_amp * sin(omega*t);

% Rectification value (Gleichrichtwert)
s_fun = @(t) abs(sin(omega*t));
s_g = (1/T) * integral(s_fun, 0, T);
s_g_y = s_g * ones(size(t));

% Plot
hold on
plot(t, s, Color=color_map{1});
plot(t, s_g_y, Color=color_map{2});
hold off
title(['Rectification value (Gleichrichtwert) for s(t) = ', num2str(s_amp), ' * sin(', num2str(omega,2) ,'\cdot{t})']);
grid on
set(gca,'Ytick', -1:0.5:1);
set(gcf,'color', [0.95,0.95,0.95]);
set(gca,'XTick', 0:pi/2:4*pi);
text(4.5*pi, s_g_y(1), strcat('$|\overline{s}| = $', num2str(s_g_y(1), 3)), "Interpreter","latex");
set(gca,'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4\pi'});
set(gca, "XAxisLocation", "origin");