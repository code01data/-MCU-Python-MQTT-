clear

format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10 10  10];
[t,y] = ode45('Baol',tspan,Y0);
figure

plot(y(1:end,2),y(1:end,3));
title('b=1.4 y-z∆Ω√Ê');
set(get(gca, 'YLabel'), 'String', 'z');
set(get(gca, 'XLabel'), 'String', 'y');


hold on