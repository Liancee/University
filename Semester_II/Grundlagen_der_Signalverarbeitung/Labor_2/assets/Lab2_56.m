% Diskretisierung (A/D-Wandlung) (5.6)
% Reset
clear all;
close all;
clc;
color_map = {[0 0.4470 0.7410], [0.96, 0.54, 0.55], [0.4660 0.6740 0.1880]};
addpath('./quant2c/');
% b) Darstellung eines Sinus-Signals
n = -1:0.001:1;
s = sin(pi*n);
figure;
plot(n, s, 'Color', color_map{2});
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);
grid on;
% c) Quantisierung des Sinus-Signals mit Quantisierungsfehler für die Breite w
w = 2:8;
for i=1:length(w)
    sq_r = quant2c(s, w(i), 'r');
    sq_t = quant2c(s, w(i), 't');
    q_fr = s - sq_r;
    q_ft = s - sq_t;

    figure;
    tiledlayout(3,2);
    nexttile([1 2]);
    plot(n, s, 'Color', color_map{2});
    title("Sinussignal");
    grid on;

    nexttile
    plot(n, sq_r, 'Color', color_map{1});
    title("Quantisiertes Sinussignal (Rundung)");
    grid on;

    nexttile
    plot(n, sq_t, 'Color', color_map{1});
    title("Quantisiertes Sinussignal (Trunkierung)");
    grid on;

    nexttile
    plot(n, q_fr, 'Color', color_map{3});
    title("Quantisierungsfehler (Rundung)");
    grid on;

    nexttile
    plot(n, q_ft, 'Color', color_map{3});
    title("Quantisierungsfehler (Trunkierung)");
    grid on;

    set(gcf, 'InvertHardcopy', 'off');
    set(gcf, 'color', [0.95,0.95,0.95]);
    sgtitle(['Quantisierung mit w = ', num2str(w(i))]);
end
% d) Quantisierung eines Tonsignals
[audio, f_s] = audioread('./quant2c/ring.wav');
w = 2:8;
for i=1:length(w)
    audio_qr = quant2c(audio, w(i), 'r');
    audio_qt = quant2c(audio, w(i), 't');
    q_fr = audio - audio_qr;
    q_ft = audio - audio_qt;

    figure;
    tiledlayout(3,2);
    nexttile([1 2]);
    plot(audio, 'Color', color_map{2});
    title("Sinussignal");
    grid on;

    nexttile
    plot(audio_qr, 'Color', color_map{1});
    title("Quantisiertes Sinussignal (Rundung)");
    grid on;

    nexttile
    plot(audio_qt, 'Color', color_map{1});
    title("Quantisiertes Sinussignal (Trunkierung)");
    grid on;

    nexttile
    plot(q_fr, 'Color', color_map{3});
    title("Quantisierungsfehler (Rundung)");
    grid on;

    nexttile
    plot(q_ft, 'Color', color_map{3});
    title("Quantisierungsfehler (Trunkierung)");
    grid on;

    set(gcf, 'InvertHardcopy', 'off');
    set(gcf, 'color', [0.95,0.95,0.95]);
    sgtitle(['Quantisierung mit w = ', num2str(w(i))]);
end