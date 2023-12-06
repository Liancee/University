% Task 4.1.1 (a): Continuous signals

% Reset
clear all;
close all;
clc;
color_map = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};

% Define parameters
omega0 = [pi/3, 3*pi/4, 3/4];
tau0 = [0, 1/2, 1/2];
theta0 = [2*pi, pi/4, 1/4];

% Time vector
t = 0:0.05:12;

% Plot configuration
tiledlayout("vertical");
for k=1:numel(omega0)    
    % Frequency and period duration
    f(k,1) = omega0(k) / (2*pi);
    T(k,1) = 1/f(k);

    % Plot signal
    nexttile;
    plot(t, cos(omega0(k)*(t-tau0(k))+theta0(k)), LineWidth=1.5, Color=color_map{k})
    grid on;
    title(['s_', num2str(k)])
    set(gcf,'color', [0.95,0.95,0.95]); 
    set(gca,'XTick', 0:pi/2:4*pi);
    set(gca,'YGrid', 'on');
    set(gca,'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4\pi'});
    set(gca, "XAxisLocation", "origin");
end

% Output
f
T