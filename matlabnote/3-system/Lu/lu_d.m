format long
tspan = 0:(1*10^(-3)):100;
Y0 = [10,10,10];
[t,y] = ode45(@lu_t,tspan,Y0);
figure

%plot(y(:,1),y(:,2))
plot3(y(1:end,3),y(1:end,1),y(1:end,2));

title('z-y-x¿Õ¼ä');