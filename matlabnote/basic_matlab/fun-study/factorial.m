%阶乘函数文件
%此函数用来求非负整数n的阶乘
%参数n可以为任意的非负整数
function Sn = factorial(n)
    if n<0
        error('error description 输入参数不能为0')
    else
        if n==0
            Sn  = 1;
        else
            Sn = 1;
            for i=1:n;
                Sn = Sn*i;
            end
        end
    
end