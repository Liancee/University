% Klingelton (5.5)

% Reset
clear all;
close all;
clc;
color_map = {[0 0.4470 0.7410], [0.96, 0.54, 0.55]};

% a) Einlesen der Datei und Darstellen des Amplitudenvektors
[audio, f_s] = audioread('./quant2c/ring.wav');
figure;
plot(audio, 'Color', color_map{2});
xlabel('Zeit');
ylabel('Amplitude');
set(gca, 'YLim', [round(min(audio),1) round(max(audio),1)]);
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);
grid on;

% b) Ausgabe der Taktfrequenz
disp(['Abtastfrequenz: ' num2str(f_s) ' Hz']);

% c) Erhöhung der Abtastfrequenz um den Faktor 2
audio_resampled = resample(audio, 2, 1);
figure;
plot(audio_resampled, 'Color', color_map{1});
xlabel('Zeit');
ylabel('Amplitude');
set(gca, 'YLim', [round(min(audio_resampled),1) round(max(audio_resampled),1)]);
set(gcf, 'InvertHardcopy', 'off');
set(gcf, 'color', [0.95,0.95,0.95]);
grid on;
