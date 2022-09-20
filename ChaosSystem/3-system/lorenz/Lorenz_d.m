format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10,10,10];
[t,y] = ode45(@Lorenz_t,tspan,Y0);
figure


plot3(y(1:end,3),y(1:end,2),y(1:end,1));
title('z-y-x�ռ�');


%{
subplot(2, 1, 2)
plot(t,y(:,1));
title('x-t����');
%}