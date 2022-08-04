function dX=chen_t(t,X)
    global a; % 变量不放入参数表中

    global b;
    
    global c;
    
    a = 36;b=3; c=20;
    x=X(1); y=X(2); z=X(3);
    
    % Y的三个列向量为相互正交的单位向量
    
    % 输出向量的初始化
    
    dX = zeros(3,1);
    
    % Lorenz吸引子
    
    dX(1)=a*(y-x);
    
    dX(2)=c*y-x*z;
    
    dX(3)=x*y-b*z;
    
end