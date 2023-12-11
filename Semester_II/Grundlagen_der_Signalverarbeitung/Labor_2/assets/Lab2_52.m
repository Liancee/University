% Impulsfolgen und Systeme II (5.2)
% Reset
clear all;
close all;
clc;
color_map = {[0 0.4470 0.7410], [0.96, 0.54, 0.55]};

% Parameter [Index 1: a), Index 2: b)]
alpha = [2, sqrt(2)];
beta = [3, 2];
x = {[0.5 -0.5 0.5], [sqrt(2) sqrt(2)]};
n = 0:5;

% Impulsfolgen x[n]
x_a = imp(n, x{1});
x_b = imp(n, x{2});

% Impulsfolgen y[n]
y_a = (imp(n, x{1}) * alpha(1) + imp(n-1, x{1})) * beta(1) + imp(n-2, x{1}) * (-1);
y_b = (imp(n, x{2}) * alpha(2) + imp(n-1, x{2})) * beta(2) + imp(n-2, x{2}) * (-1);

% Darstellung von x[n] und y[n]
for i=1:2
    figure;
    task = char(i + 96);

    tiledlayout("vertical");
    ymin = min([eval(sprintf('x_%c', task)), eval(sprintf('y_%c', task))], [], "all");
    ymax = max([eval(sprintf('x_%c', task)), eval(sprintf('y_%c', task))], [], "all");
    for j=1:2 
        if (j == 1)
            xvalues = eval(sprintf('x_%c', task));
        else
            xvalues = eval(sprintf('y_%c', task));
        end

        nexttile
        hold on;
        stem(n, xvalues, 'Color', color_map{j});
        xlabel('n');
        ylabel(sprintf('x_%c[n]', task));
        xlim([0 Inf]);
        ylim([ymin ymax]);
        subtitle(sprintf('Impulsfolge x_%c[n]', task));
        grid on;
    end
    set(gcf, 'InvertHardcopy', 'off');
    set(gcf, 'color', [0.95,0.95,0.95]);
end

function imp = imp(n, x)
    % erweitere n, wenn Verzögerung
    n_min = min(n);
    n_max = max(n);
    n = 0:abs(n_min)+n_max;

    y = zeros(max(size(n)), numel(n));
    index = 1;
    for i=n
        y(index, :) = dirac(n-i) == Inf;
        index = index + 1;
    end

    imp_unshifted = zeros(numel(n));
    for i=1:numel(x)
        imp_unshifted(i,:) = x(i) * y(i,:);
    end
    imp_unshifted = sum(imp_unshifted);

    if (abs(n_min) > 0) 
        for i=1:abs(n_min)
            imp_unshifted = imp_unshifted * (-1);
        end
    end 
    imp = zeros(size(imp_unshifted));
    imp(abs(n_min)+1:end) = imp_unshifted(1:end-abs(n_min));
end