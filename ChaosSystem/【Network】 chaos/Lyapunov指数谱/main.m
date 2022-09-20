
% 计算系统的Lyapunov指数谱
clc     % 清屏
clear   % 清除所有变量

global a b c d e;
a = 20;
b = 5;
c = 10;
d = 2;
e = 4;

H = 0:0.1:40;
L = length(H);
ly = zeros(4, L);

for i = 1:L
    h = H(i);
    [T, Res] = lyapunov(4, @myfun_ly, @ode45, 0, 0.01, 200, [1 1 1 1], 5);
    ly(:, i) = Res(end, :);
end 

plot(H, ly);
xlabel('\ith');
ylabel('\itLyapunov');

% [T, Res] = lyapunov(4, @fun_ly, @ode45, 0, 0.01, 200, [10 10 10 10], 100);

% Res(end, :)