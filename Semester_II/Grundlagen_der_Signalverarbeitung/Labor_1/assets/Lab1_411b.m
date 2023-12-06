% Task 4.1.1 (b): Continuous signals

% Reset
clear all;
close all;
clc;
color_map_1 = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};
color_map_2 = {[0.55, 0.55, 1], [0.96, 0.54, 0.55], [1, 0.72, 0.55]};

% Define parameters
omega_x = [pi/3, 3*pi/4, 3/4];
tau_x = [0, 1/2, 1/2];
theta_x = [2*pi, pi/4, 1/4];

omega_y = [pi/3, 11*pi/4, 3/4];
tau_y = [1, 1, 1];
theta_y = [-7*pi/6, 3*pi/8, 13/8];

% Time vector
t = 0:0.05:12;

% Plot configuration
tiledlayout("vertical");
for k=1:3
    % Plot signal
    nexttile;
    hold on
    plot(t, cos(omega_x(k)*(t-tau_x(k))+theta_x(k)), LineWidth=1.5, Color=color_map_1{k})
    plot(t, cos(omega_y(k)*(t-tau_y(k))+theta_y(k)), LineWidth=1.5, Color=color_map_2{k})
    hold off

    grid on;
    title(['Signal combination ', num2str(k), ' (s_{1', num2str(k), '}(t) \leftrightarrow s_{2', num2str(k), '}(t))'])
    set(gcf,'color', [0.95,0.95,0.95]);
    set(gca,'XTick', 0:pi/2:4*pi);
    set(gca,'YGrid', 'on');
    set(gca,'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4\pi'});
    set(gca, "XAxisLocation", "origin");
end