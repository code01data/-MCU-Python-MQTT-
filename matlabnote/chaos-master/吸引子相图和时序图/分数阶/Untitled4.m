clc
clear
order = 0.93; % ½×Êı
[x y z ] = solveFractionalOrder_three(order, order, order); 
figure(1)
plot(x(5000:end),y(5000:end),'r')
xlabel('\itx');
ylabel('\ity')
figure(2)
plot(x(5000:end),z(5000:end),'b')
title('x-zÏàÍ¼');
xlabel('\itx');
ylabel('\itz');
figure(3)
plot(y(5000:end),z(5000:end),'m')
xlabel('\ity');
ylabel('\itz')