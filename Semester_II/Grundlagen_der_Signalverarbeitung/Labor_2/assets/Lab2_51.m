% Impulsfolgen und Systeme I (5.1)
% Reset
clear all;
close all;
clc;
color_map = {[0 0.4470 0.7410], [0.96, 0.54, 0.55]};

% Impulsfolge x[n]
a = 0.25;
b = 0.5;
c = 0.75;
n = 0:5;
y = zeros(5, numel(n)); % 5x6 matrix
for i=n
    y(i+1, :) = dirac(n - i) == Inf;
end
x = a * y(1, :) + b * y(2, :) + c * y(3, :) - a * y(4, :) - b * y(5, :) - c * y(6, :);

% Impulsfolge y[n]
y = (abs(x) - x.^2).^2;

% Darstellung von x[n] und y[n]
tiledlayout("vertical");
nexttile
hold on;
stem(n, x, 'Color', color_map{1});
xlabel('n');
ylabel('x[n]');
subtitle('Impulsfolge x[n]');
grid on;

nexttile;
stem(n, y, 'Color', color_map{2});
xlabel('n');
ylabel('y[n]');
subtitle('Impulsfolge y[n]');
grid on;
hold off;
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);