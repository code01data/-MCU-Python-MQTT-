function Baol_phase

format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10 10  10];
[t,y] = ode45('Baol',tspan,Y0);
figure

subplot(3,2,1)
plot3(y(1:end,3),y(1:end,2),y(1:end,1));
title('z-y-x�ռ�');
subplot(3,2,2)
plot(y(1:end,1),y(1:end,2));
title('x-yƽ��');
subplot(3,2,3)
plot(y(1:end,1),y(1:end,3));
title('x-zƽ��');
subplot(3,2,4)
plot(y(1:end,2),y(1:end,3));
title('y-zƽ��');
subplot(3,2,5)
plot(t,y(:,1));
title('x-t����');
subplot(3,2,6)
plot(t,y(:,2));
title('z-t����');

hold on