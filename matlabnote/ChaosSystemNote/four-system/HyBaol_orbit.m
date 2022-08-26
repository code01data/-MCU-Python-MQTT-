function HyBaol_orbit

format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10 10  10 10];
[t,y] = ode45('HyBaol',tspan,Y0);
figure

subplot(2,2,1)
plot3(y(1:end,3),y(1:end,2),y(1:end,1));
set(get(gca, 'XLabel'), 'String', 'x');
set(get(gca, 'YLabel'), 'String', 'y');
set(get(gca, 'ZLabel'), 'String', 'z');
title('z-y-x�ռ�');
subplot(2,2,2)
plot(y(20000:end,1),y(20000:end,3));%(a,b,1)1��ʾx 2��ʾy 3��ʾz
set(get(gca, 'XLabel'), 'String', 'x');
set(get(gca, 'YLabel'), 'String', 'z');
title('x-zƽ��');
subplot(2,2,3)
plot(y(20000:end,2),y(20000:end,3));
set(get(gca, 'XLabel'), 'String', 'y');
set(get(gca, 'YLabel'), 'String', 'z');
title('y-zƽ��');
subplot(2,2,4)
plot(y(20000:end,3),y(20000:end,4));
set(get(gca, 'XLabel'), 'String', 'z');
set(get(gca, 'YLabel'), 'String', 'w');
title('z-wƽ��');
hold on