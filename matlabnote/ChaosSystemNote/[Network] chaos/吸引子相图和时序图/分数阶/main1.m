% 计算相图
clc;
clear;
close all;
order = 0.99; % 0.6阶无解
% [x y z ] = solveFractionalOrder_three(order, order, order);  %下面是四阶的
[x y z w] = solveFractionalOrder(order, order, order, order);


% tm = floor(length(x)*0.1):length(x); 
% tm = floor(length(x)):length(x); 
figure(1)
% subplot(2, 3, 1);
plot(x(1000:end), y(1000:end), 'color', [0.1 0.9 0.7]);
xlabel('x');
ylabel('y');
title('x-y');

% subplot(2, 3, 2);
% figure(2)
% plot(x(tm), z(tm), 'color', [0.1 0.2 0.7]);
% xlabel('x');
% ylabel('z');
% title('x-z');
% 
% % subplot(2, 3, 3);
% 
% plot(x(tm), w(tm), 'color', [0.5 0.6 0.1]);
% xlabel('x');
% ylabel('w');
% title('x-w');

% subplot(2, 3, 4);

% figure(3)
% plot(y(tm), z(tm), 'color', [0.1 0.9 0.7]);
% xlabel('y');
% ylabel('z');
% title('y-z');

% subplot(2, 3, 5);
% plot(y(tm), w(tm), 'color', [0.1 0.2 0.7]);
% xlabel('y');
% ylabel('w');
% title('x-w');

% subplot(2, 3, 6);
% plot(z(tm), w(tm), 'color', [0.5 0.6 0.1]);
% xlabel('z');
% ylabel('w');
% title('z-w');


% figure;
% subplot(1, 2, 1);

% plot3(x(tm), y(tm), z(tm),  'color', [0.1 0.9 0.8]);
% xlabel('x');
% ylabel('y');
% zlabel('z');

% subplot(1, 2, 2);
% plot3(x(tm), y(tm), w(tm),  'color', [0.1 0.3 0.8]);
% xlabel('x');
% ylabel('y');
% zlabel('w');

% figure;
% plot(tm * 0.005, x(tm), 'color', [0.2 0.5 0.65]);
% xlabel('t');
% ylabel('x');
% title('t-x');
 
