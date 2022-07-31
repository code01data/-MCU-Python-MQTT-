%阶乘求和函数文件
function Sumsn = sum_factorial(n1)
    if n1<0
        error('error description 输入参数不能为0');
        return;
    else
        Sumsn =0;
        for i = 1:n1
            Sumsn = Sumsn+1/factorial(i);%调用其他自定义函数文件
        end
    
end