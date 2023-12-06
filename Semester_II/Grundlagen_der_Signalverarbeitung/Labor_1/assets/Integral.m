t=-20:0.2:10;

y=(1-exp(t)).*sin(2*pi.*t)/2*pi.*t;

y=(1-exp(-t)).*sin(t);


a=1;
f = @(t) (1-exp(-t)).*sin(t);
v=integral(f, 0, a)


plot(t,y);




y = @(t) (1-exp(-t)).*sin(t);
x = linspace(-20, 20, 100);
inty = cumtrapz(x,y(x));
figure(1)
plot(x, inty, '-k', 'LineWidth',1)
hold on
patch([x fliplr(x)], [zeros(size(x)) fliplr(inty)], 'g')
hold off
grid