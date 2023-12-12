% Simulierte Impulsfolgen (5.4)

% Reset
clear all;
close all;
clc;
color_map = {[0 0.4470 0.7410], [0.96, 0.54, 0.55]};

% a1) Datei einlesen
fd = fopen('./quant2c/RLC_Impulse_1.txt', 'r');
data = fscanf(fd, '%f', [2 Inf])';
fclose(fd);

% a2) Dimension der Datei bestimmen
dimension = size(data);

% a3) Zeit-/Amplitudenvektor auslesen und Darstellen des Impulses
t = data(:, 1);     % Zeitvektor
amp = data(:, 2);   % Amplitudenvektor

stem(t, amp, 'Color', color_map{2});
xlabel('Zeit');
ylabel('Amplitude');
title('Gewichtete Impulsfolge');
set(gca, 'YLim', [round(min(amp),1) round(max(amp),1)]);
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);
grid on;

% b) Plot des Zeitvektors, erster Ableitung und Referenzgeraden
t_diff = diff(t);
t_ref = linspace(t(1), t(end), numel(t));
t_diff_ref = diff(t_ref);
t_diff_ref_y = linspace(t_diff_ref(1), t_diff_ref(end), numel(t_diff_ref));

figure;
tiledlayout("vertical");
nexttile
hold on;
plot(t, 'Color', color_map{2}); % Zeitvektor
plot(1:numel(t), t_ref, 'Color', color_map{1}, 'LineStyle', '--'); % Referenzgerade
xlim([0 numel(t)-1]);
grid on;
hold off;

nexttile
hold on;
plot(t(1:end-1), t_diff, 'Color', color_map{2});
plot(t(1:end-1), t_diff_ref_y, 'Color', color_map{1}, 'LineStyle', '--'); % Referenzgerade
grid on;
hold off;
set(gcf, 'InvertHardcopy', 'off');
set(gcf,'color', [0.95,0.95,0.95]);

% c) Interpolation des Amplitudenvektors

t_equidistant = linspace(min(t), max(t), length(t)); % Äquidistanter Zeitvektor
amp_interp = interp1(t, amp, t_equidistant, 'linear'); % Amplitudenvektor interpolieren

figure;
stem(t_equidistant, amp_interp, 'Color', color_map{2});
xlabel('Zeit');
ylabel('Amplitude');
title('Äquidistante Impulsfolge');
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);
grid on;