function [ x y z w] = solveFractionalOrder(q1, q2, q3, q4)
% 利用预估矫正法求解分数阶

% 伽玛函数（Gamma函数），也叫欧拉第二积分，是阶乘函数在实数与复数上扩展的一类函数
% https://baike.baidu.com/item/%E4%BC%BD%E7%8E%9B%E5%87%BD%E6%95%B0/3540177?fromtitle=gamma%E5%87%BD%E6%95%B0&fromid=10819772&fr=aladdin
    
    % 用户需要修改的：迭代次数
    h = 0.01;	% 迭代步长
    N = 5000;   % 迭代步数
    
    
    % 用户需要修改的：系统初值
    x0 = 1;
    y0 = 2;
    z0 = 3;
    w0 = 4;

    
    M1 = 0;
    M2 = 0;
    M3 = 0;
    M4 = 0;
    
    x(N+1) = [0];
    y(N+1) = [0];
    z(N+1) = [0];
    w(N+1) = [0];
    
    x1(N+1) = [0];
    y1(N+1) = [0];
    z1(N+1) = [0];
    w1(N+1) = [0];
    
    tmp0 = myFun(x0, y0, z0, w0);
    x1(1) = x0 + h^q1 * tmp0(1) / (gamma(q1) * q1);
    y1(1) = y0 + h^q2 * tmp0(2) / (gamma(q2) * q2);
    z1(1) = z0 + h^q3 * tmp0(3) / (gamma(q3) * q3);
    w1(1) = w0 + h^q4 * tmp0(4) / (gamma(q4) * q4);
    
    % 书上这样写
    tmp1 = myFun(x1(1), y1(1), z1(1), w1(1));
    x(1) = x0 + h^q1 * (tmp1(1) + q1 * tmp0(1)) / gamma(q1 + 2);
    y(1) = y0 + h^q2 * (tmp1(2) + q2 * tmp0(2)) / gamma(q2 + 2);
    z(1) = z0 + h^q3 * (tmp1(3) + q3 * tmp0(3)) / gamma(q3 + 2);
    w(1) = w0 + h^q4 * (tmp1(4) + q4 * tmp0(4)) / gamma(q4 + 2);
    
    % 学姐给的这样写
% 	x(1) = x0 + h^q1 * tmp1(1) / gamma(q1 + 2);
%     y(1) = y0 + h^q2 * tmp1(2) / gamma(q2 + 2);
%     z(1) = z0 + h^q3 * tmp1(3) / gamma(q3 + 2);
%     w(1) = w0 + h^q4 * tmp1(4) / gamma(q4 + 2);
    
    for n = 1:N
        
        str = ['运算进度：', num2str(n)];
        disp(str);
        M1 = (n^(q1 + 1) - (n - q1) * (n + 1)^q1) * tmp0(1); 
        M2 = (n^(q2 + 1) - (n - q2) * (n + 1)^q2) * tmp0(2); 
        M3 = (n^(q3 + 1) - (n - q3) * (n + 1)^q3) * tmp0(3);
        M4 = (n^(q4 + 1) - (n - q4) * (n + 1)^q4) * tmp0(4);

        N1 = ((n + 1)^q1 - n^q1) * tmp0(1); 
        N2 = ((n + 1)^q2 - n^q2) * tmp0(2);
        N3 = ((n + 1)^q3 - n^q3) * tmp0(3);
        N4 = ((n + 1)^q4 - n^q4) * tmp0(4);
        
        for j = 1:n
            tmpj = myFun(x(j), y(j), z(j), w(j));
            M1 = M1 + ((n - j + 2)^(q1 + 1) + (n - j)^(q1 + 1) - 2 * (n - j + 1)^(q1 + 1)) * tmpj(1);
            M2 = M2 + ((n - j + 2)^(q2 + 1) + (n - j)^(q2 + 1) - 2 * (n - j + 1)^(q2 + 1)) * tmpj(2);
            M3 = M3 + ((n - j + 2)^(q3 + 1) + (n - j)^(q3 + 1) - 2 * (n - j + 1)^(q3 + 1)) * tmpj(3);
            M4 = M4 + ((n - j + 2)^(q4 + 1) + (n - j)^(q4 + 1) - 2 * (n - j + 1)^(q4 + 1)) * tmpj(4);
          
            N1 = N1 + ((n - j + 1)^q1 - (n - j)^q1) * tmpj(1);
            N2 = N2 + ((n - j + 1)^q2 - (n - j)^q2) * tmpj(2);
            N3 = N3 + ((n - j + 1)^q3 - (n - j)^q3) * tmpj(3);
            N4 = N4 + ((n - j + 1)^q4 - (n - j)^q4) * tmpj(4);
        end 
        
        x1(n+1) = x0 + h^q1 * N1 / (gamma(q1) * q1);
        y1(n+1) = y0 + h^q2 * N2 / (gamma(q2) * q2);
        z1(n+1) = z0 + h^q3 * N3 / (gamma(q3) * q3);
        w1(n+1) = w0 + h^q4 * N4 / (gamma(q4) * q4);

        tmpn_1 = myFun(x1(n + 1), y1(n + 1), z1(n + 1), w1(n + 1));
        x(n+1) = x0 + h^q1 * (tmpn_1(1) + M1) / gamma(q1 + 2); 
        y(n+1) = y0 + h^q2 * (tmpn_1(2) + M2) / gamma(q2 + 2); 
        z(n+1) = z0 + h^q3 * (tmpn_1(3) + M3) / gamma(q3 + 2); 
        w(n+1) = w0 + h^q4 * (tmpn_1(4) + M4) / gamma(q4 + 2); 
        
    end 
end






