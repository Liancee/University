% Task 4.1.2: Simple continuous signals

% Reset
clear all;
close all;
clc;
color_map_1 = {[0.18, 0.18, 0.57], [0.93, 0.11, 0.14], [0.96, 0.51, 0.22]};
color_map_2 = {[0.55, 0.55, 1], [0.96, 0.54, 0.55], [1, 0.72, 0.55]};

% Time vector (with doubling in the middle)
t = -6:7;
for i = 1:length(t)
    if (t(i) > 0)
        t(i) = t(i)-1;
    end
end

% Given signal
s_G = s(t, 1, 0); % s(t)

% Modified signals
s_a = s(t, -1, 0); % s(-t)
s_b = s(t, 1, 2); % s(t+2)
s_c = s(t, 2, 2); % s(2*t+2)
s_d = s(t, -3, 1); % s(1-3*t)

signals = {s_G, s_a, s_b, s_c, s_d};
signal_axis = {s_G, s_a, s_b, s_c, s_d};
signal_titles = {'s(t)', 'a) s(-t)','b) s(t+2)','c) s(2t+2)', 'd) s(1-3t)'};

% Plots
tiledlayout("vertical");
for i=1:length(signals)
    nexttile
    plot(signals{1,i}{1,1}, signals{1,i}{1,2});
    title([signal_titles(1,i)]);
    grid on
    xlim([-6, 6]);
    set(gca,'Xtick', -6:1:6);
    set(gca,'Ytick', 0:0.5:1);
end
set(gcf,'color', [0.95,0.95,0.95]);

% Function definition
function y=s(t, scale, shift)
    % Scaling of x-axis
    t = t/scale;

    % x-axis displacement
    for i=1:length(t)
        if (t(i) == t(i+1))
            if (shift ~= 0)
                step_size = t(2) - t(1);
                start_value = t(i-shift);
                for j=i-shift+1:length(t)
                    t(j) = start_value;
                    start_value = start_value + step_size;
                end
                mid_index = i-shift;
            else
                mid_index = i;
            end
            break
        end
    end

    y = zeros(size(t));
    y(mid_index+1:mid_index+3) = -(1/3) * (t(mid_index+1:mid_index+3)*scale+shift) + 1;
    y = {t,y};
end