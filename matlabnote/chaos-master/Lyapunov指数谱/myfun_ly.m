function xDot = fun_ly( t, X )
% 计算李Lyapunov指数谱 所需要的数列

    global a b c d e;

    % 初值
    x = X(1);  
    y = X(2);
    z = X(3);
    w = X(4);
    
    % 不是很明白
    Y = [X(5), X(9),  X(13), X(17);
         X(6), X(10), X(14), X(18);
         X(7), X(11), X(15), X(19);
         X(8), X(12), X(16), X(20)];

    % chen系统方程
    xDot = zeros(20, 1);   % 初始化f为12 * 1 的列向量
    xDot(1)= -a * x + y * z;
    xDot(2) = -x + c * y + w;
    xDot(3) = d * x * y - b * z;
    xDot(4) = -e * y;
    
    
    Jac = [ -a,     z,      y,  0;
            -1, 	c,      0,  1;
            d*y,    d*x,    -b, 0;
            0,      -e,     0,  0];
    
    % xDot(4:12)用来干什么？？？
    xDot(5:20) = Jac * Y;    
end

