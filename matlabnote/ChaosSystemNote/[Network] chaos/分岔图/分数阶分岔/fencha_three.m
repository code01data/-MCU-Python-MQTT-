% 计算分岔图
clc
clear
close all;
global q;   % 全局变量a

H = 0.7:0.001:1;
L = length(H);

num1 = zeros(1, 2);
numIndex = 1;
for i = 1:L
    q = H(i);
    disp(q);
    [ x y z ] = solveFractionalOrder_three(q, q, q);
    data = z(5000:end);     % 保留z的数据
    
    for j = 2:(length(data) - 1)
        if data(j) > data(j-1) && data(j) > data(j+1)
%             plot(q, data(j), '.', 'markersize', 1);
            num1(numIndex, 1) = q;
            num1(numIndex, 2) = data(j);
            numIndex = numIndex + 1;
            hold on;
            
%             if j == 20
%                 break;
%             end
        end
    end

end

xlabel('\it q');
ylabel('\itX');