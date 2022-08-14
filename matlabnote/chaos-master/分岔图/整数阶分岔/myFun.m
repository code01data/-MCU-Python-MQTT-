% 超混沌Shen系统
function xDot = myFun(t, X)
    global a b c d;   % 全局变量

    x = X(1);
    y = X(2);
    z = X(3);
    w = X(4);
    
    xDot = zeros(4, 1);
    xDot(1) = -a * x + y * z;
    xDot(2) = x*z -y^3;
    xDot(3) = -b* x * y +c* z+w;
    xDot(4) =  y-d*z;
end

