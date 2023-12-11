% Impulskamm und diskrete Impulsfolge (5.3)

% Reset
clear all;
close all;
clc;
color_map = {[0 0.4470 0.7410], [0.96, 0.54, 0.55]};

% a) Impulskamm
L = 10;
t = 0:1:L;
impuls = zeros(L, numel(t));
for n=0:1:L
    impuls(n+1, :) = dirac(t-n) == Inf;
end

figure;
stem(t, impuls, 'Color', color_map{1});
xlabel('n');
ylabel('\delta[n]');
subtitle('Impulskamm mit n = 10');
grid on;
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);

% b) Diskrete Sinus-Schwingung als Impulsfolge
s = sin(1.25*t)*impuls;
figure;
hold on
setFigureProps(color_map{2});
plot(t, s, 'Color', color_map{1});
stem(t, s, 'Color', color_map{1});
hold off;
subtitle('Diskrete Sinus-Schwingung');

% c) Vergleich von Interpolationsfunktionen / Resample
figure;
tiledlayout(5,2);
nexttile([1 2]);
hold on;
setFigureProps(color_map{2});
plot(t, s, 'Color', color_map{1});
stem(0:1:L, s, 'Color', color_map{1});
subtitle('original');
hold off;

% Interpolation
t_int = 0:0.5:L;
s_nearest = interp1(t, s, t_int, 'nearest'); 
s_linear = interp1(t, s, t_int, 'linear');
s_pchip = interp1(t, s, t_int, 'pchip');
s_spline = interp1(t, s, t_int, 'spline');
methods = {'nearest', 'linear', 'pchip', 'spline'};

diff = cell(numel(methods), 1);
for i=1:numel(methods)
    nexttile
    hold on;
    setFigureProps(color_map{2});
    plot(t_int, eval(sprintf('s_%s', methods{i})), 'Color', color_map{1});
    stem(t_int, eval(sprintf('s_%s', methods{i})), 'Color', color_map{1});
    subtitle(methods{i});
    hold off;

    % Differenz
    values_sin = sin(1.25*t);
    values_int = eval(sprintf('s_%s', methods{i}));
    target = sin(1.25*t_int);
    delta = target - values_int;
    diff{i} = [t_int; target; values_int; delta];
    for j=1:numel(t_int)
        line([t_int(j) t_int(j)], [diff{i}(3,j) diff{i}(2,j)], 'Color', 'red');
    end
    
    % export data
    writecell([{'n', 'sin', 'sn', 'delta'}; num2cell(transpose(diff{i}))], sprintf('%s.csv',methods{i}));
end

% Resample
p_resample = [3 2 2 5];
q_resample = [2 1 3 5];
s_q = ['>', '>>', '<', '='];
for i=1:numel(p_resample)
    s_resample = resample(s, p_resample(i), q_resample(i));
    t_resample = (0:(length(s_resample)-1))*p_resample(i)/q_resample(i);

    nexttile
    hold on;
    setFigureProps(color_map{2});
    plot(t_resample, s_resample, 'Color', color_map{1});
    stem(t_resample, s_resample, 'Color', color_map{1});
    subtitle(sprintf('resample p=%d, q=%d, S_q %s 1', p_resample(i), q_resample(i), s_q(i)));
    hold off;
end

function setFigureProps(color)
    t = 0:0.01:4*pi;
    plot(t, sin(1.25*t), 'LineWidth', 1.5, 'Color', color);
    xlabel('n');
    ylabel('s[n]');
    xlim([0 10]);
    ylim([-1.5 1.5]);
    grid on;
    set(gcf, 'InvertHardcopy', 'off');
    set(gcf, 'color', [0.95,0.95,0.95]);
end