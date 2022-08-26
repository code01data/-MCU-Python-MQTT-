format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10,10,10];
[t,y] = ode45(@chen_t,tspan,Y0);
figure

%plot(y(:,1),y(:,2))
plot3(y(1:end,3),y(1:end,1),y(1:end,2));

title('z-y-x空间');

%{
subplot(2, 1, 2)
plot(t,y(:,1));
title('x-t波形');

subplot(2,1,2)
plot(y(1:end,1),y(1:end,3));
set(get(gca, 'XLabel'), 'String', 'x');
set(get(gca, 'YLabel'), 'String', 'z');
title('x-z平面');
%}


