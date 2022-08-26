% 分岔图
clc;
clear;
close all;
global a b c d ;   % 全局变量
a = 6;
b = 4;
d = 2;

% 设置：参数的变化范围
value = 8:0.01:30;  % *修改1：参数范围
value_len = length(value);

num1 = zeros(1, 2);
numIndex = 1;
for i = 1:value_len
    fprintf('%f\n', value(i));
    coordX = value(i);   
    c = coordX;  	% *修改2：参数
    [T, Y] = ode45(@myFun, 0:0.01:100, [1 2 3 4]);
    data = Y(floor(length(T) * 0.5):end, 2);    % *修改3：要观察的因子
    
    for j = 2:(length(data) - 1)
        if data(j) > data(j-1) && data(j) > data(j+1)
            plot(coordX, data(j), '.', 'markersize', 2);
            % 对数据点进行保存，方便下次画图
            num1(numIndex, 1) = coordX;
            num1(numIndex, 2) = data(j);
            numIndex = numIndex + 1;
            hold on;
        end
    end

end

xlabel('\itC');
ylabel('\itYmax');
