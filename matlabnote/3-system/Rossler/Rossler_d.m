format long
tspan = 0:(1*10^(-3)):500;
Y0 = [10,10,10];
[t,y] = ode45(@Rossler_t,tspan,Y0);
figure


plot3(y(1:end,3),y(1:end,2),y(1:end,1));
title('z-y-x¿Õ¼ä');


%{
    subplot(2, 1, 2)
    plot(t,y(:,1));
    title('x-t²¨ÐÎ');
%}