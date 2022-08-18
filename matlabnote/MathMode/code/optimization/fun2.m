%非线性函数

function [C,Ceq] = fun2(x)
    C = -x(1)^2+x(2);   %matlab标准，不等式通通都是小于号 所以取负号
    Ceq = x(1)+x(2)^2-2;
end