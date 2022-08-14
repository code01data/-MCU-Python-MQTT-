function xDot = myFun(x, y, z)

%     global a;
    global b;
%     global c;
%     global d;
%     a = 6;  %修改参数
    b = 0.5;
%     c = 2;
%     d = 2;
    
    

%     xDot = zeros(3, 1);
%     xDot(1) = 10*(y-x);
%     xDot(2) = (24-4*c)*x-x*z+c*y;
%     xDot(3) = x*y-8*z/3;

%% --------------------分数阶系统 -----------------------%%
%     xDot = zeros(4, 1);
%     xDot(1) = -a*x+y*z;
%     xDot(2) = x*z-y^3;
%     xDot(3) = -b*x*y+c*z+w;
%     xDot(4) = y-d*z;



end 

