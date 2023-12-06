% Task 4.1.5: Periodic signal

% Reset
clear all;
close all;
clc;
color_map = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};

% Time vector
T = 6;
num_T = 2;
t = 0:num_T*T+num_T;
for i=1:length(t)
    if (mod(i,7) == 0)
        for j=i+1:length(t)
            t(j) = t(j) - 1;
        end
    end
end

% Plot
plot(t, s(t), Color=color_map{1});
title('s(t)');
grid on
set(gca,'Ytick', 0:0.5:1);
set(gca,'Xtick', 0:T*num_T);
set(gcf,'color', [0.95,0.95,0.95]);


% Function definition
function y=s(t)
    % Function values are initially all 0
    y = zeros(size(t));

    % Function period
    T = 6;
    v = 0:T;

    % Definition of the function for a period
    yy = zeros(1, T+1);
    yy(1:3) = -(1/3) * v(v < 3) + 1;
    
    % Repeat period function, for complete periods
    y(1:floor(max(t) / T) * T + floor(max(t) / T)) = repmat(yy, 1, floor(max(t) / T))
end