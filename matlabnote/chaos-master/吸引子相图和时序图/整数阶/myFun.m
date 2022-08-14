% -----自激双翼吸引子的四维混沌系统-----
% -----Sambas A,Vaidyanathan S,Zhang S,Mujiarto,Mamat M,Subiyanto,Sanjaya W. S. Mada. A New 4-D Chaotic System with Self-Excited Two-Wing Attractor, its Dynamical Analysis and Circuit Realization[J]. Journal of Physics: Conference Series,2019,1179:

function xDot = myFun(t, X)
    global a b ;   % 全局变量
    

    x = X(1);
    y = X(2);
    z = X(3);
    w = X(4);
    
    xDot = zeros(4, 1);
    xDot(1) = a*(y-x)-w;
    xDot(2) = x*z ;
    xDot(3) = b-x*y;
    xDot(4) =  x-w;
end