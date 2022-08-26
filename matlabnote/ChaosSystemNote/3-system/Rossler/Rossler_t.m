function dX=Rossler_t(t,X)
    global a; % 变量不放入参数表中

    global b;
    
    global c;
    
   % a = 0.2;b=0.2; c=5.7;   %混沌电路导论
    a = 0.35;b=0.4; c=4.9;  
    x=X(1); y=X(2); z=X(3);
    
    % Y的三个列向量为相互正交的单位向量
    
    % 输出向量的初始化
    
    dX = zeros(3,1);
    
    % Lorenz吸引子
    
    dX(1)=-y-z;
    
    dX(2)=x+a*y;
    
    dX(3)=b+z*(x-c);
    
end