clc
clear
% close all;
% global c;
% c = 2;

[t, Y] = ode45(@Siwei, 0:0.01:500, [1 1 1 1]);
A = 3;  % z 
B = 2;  % y
D = 1;  % x

m = 0;     % 截面的值 根据吸引子相图确定截面
N = length(Y);  % 求迭代数据的长度 500 / 0.01 + 1
for k = 1 : N-1
    if (Y(k, A) > m && Y(k+1, A) < m) || (Y(k, A) < m && Y(k+1, A) > m)  % 在z轴上截取一个平面
        a = (Y(k+1, A) - Y(k, A)) / (t(k+1) - t(k));                    % 选取的截面
        b = (Y(k, A) * t(k+1) - Y(k+1, A) * t(k)) / (t(k+1) - t(k));    % t = 0 z线的截距(坐标)
        c = (Y(k+1, B) - Y(k, B)) / (t(k+1) - t(k));                    % y线的斜率
        d = (Y(k, B) * t(k+1) - Y(k+1, B) * t(k)) / (t(k+1) - t(k));    % t = 0 y线的截距(坐标)
        e = (Y(k+1, D) - Y(k, D)) / (t(k+1) - t(k));                    % x线的斜率
        f = (Y(k, D) * t(k+1) - Y(k+1, D) * t(k)) / (t(k+1) - t(k));    % t = 0 x线的截距(坐标)
        g = (m - b) / a;    % z = 10时所需要的坐标
        q = e * g + f;    	% z = 10时x的值
        p = c * g + d;    	% z = 10时y的值
        %disp ([k, q, p]);
        plot(q, p, '.');
        hold on;
    end
end

xlabel('x');
ylabel('y');