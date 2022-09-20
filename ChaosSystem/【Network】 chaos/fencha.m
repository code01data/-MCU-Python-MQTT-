
% 计算分岔图
clc
clear
global d; 
q=0.95;% 全局变量a

D = 0:0.01:4;
L = length(D);


for i = 1:L
    d = D(i);
    disp(d);
    [ x y z] = solveFractionalOrder(q, q, q);
    data = x(5000:end);     % 保留x的数据
    
    for j = 2:(length(data) - 1)
        if data(j) > data(j-1) && data(j) > data(j+1)
            plot(d, data(j), '.', 'markersize', 1);
            hold on;
            
%             if j == 20
%                 break;
%             end
        end
    end

end

xlabel('\itH');
ylabel('\itXmax');