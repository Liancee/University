% Task 4.1.7: Parameter of a periodic signal - B

% Reset
clear all;
close all;
clc;
color_map = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};

% Time vector
t = 0:0.05:4.5*pi;

% Function parameters
T=2*pi; % Period duration
f=1/T; % Frequency
omega = 2*pi/T; % Circular frequency
s_amp = 1; % Amplitude

s_g_0 = sqrt(3)/2;

% Function
s = s_amp * sin(omega*t) + s_g_0;

% Equivalent value (Gleichwert)
s_t_gw = (1/T) * integral(@(t) s_amp*sin(omega*t)+s_g_0, 0, T);
s_t_gw_y = s_t_gw * ones(size(t));

% Rectification value (Gleichrichtwert)
s_t_grw = (1/T) * integral(@(t) abs(s_amp*sin(omega*t)+s_g_0), 0, T);
s_t_grw_y = s_t_grw * ones(size(t));

% Plot
hold on
plot(t, s);
plot(t, s_t_grw_y, Color=color_map{1});
plot(t, s_t_gw_y, Color=color_map{2});
hold off
title(['Equivalent/Rectification value (Gleich- und Gleichrichtwert) for s(t) = ', num2str(s_amp), ' * sin(', num2str(omega,2) ,'\cdot{t}) + \surd3/2']);
grid on
set(gca,'Ytick', -1:0.5:2);
set(gcf,'color', [0.95,0.95,0.95]);
set(gca,'XTick', 0:pi/2:4*pi);
text(4.5*pi, s_t_gw_y(1) - 0.05, strcat('$\overline{s} = $', num2str(s_t_gw(1), 3)), "Interpreter","latex");
text(4.5*pi, s_t_grw_y(1) + 0.05, strcat('$|\overline{s}| = $', num2str(s_t_grw_y(1), 3)), "Interpreter","latex");
set(gca,'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4\pi'});
set(gca, "XAxisLocation", "origin");