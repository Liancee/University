% Simulierte Impulsfolgen (5.4a)

% 1) Datei einlesen
file_identifier = fopen('./quant2c/RLC_Impulse_1.txt', 'r');
data = fscanf(file_identifier, '%f', [2 Inf])';


% 2) Dimension der Datei bestimmen
dimension = size(data);

fclose(file_identifier);