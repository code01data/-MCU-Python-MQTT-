function Baol_phase

format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10 10  10];
[t,y] = ode45('Baol',tspan,Y0);
figure

subplot(3,2,1)
plot3(y(1:end,3),y(1:end,2),y(1:end,1));
title('z-y-x空间');
subplot(3,2,2)
plot(y(1:end,1),y(1:end,2));
title('x-y平面');
subplot(3,2,3)
plot(y(1:end,1),y(1:end,3));
title('x-z平面');
subplot(3,2,4)
plot(y(1:end,2),y(1:end,3));
title('y-z平面');
subplot(3,2,5)
plot(t,y(:,1));
title('x-t波形');
subplot(3,2,6)
plot(t,y(:,2));
title('z-t波形');

hold on