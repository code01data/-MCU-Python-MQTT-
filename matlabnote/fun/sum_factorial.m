%�׳���ͺ����ļ�
function Sumsn = sum_factorial(n1)
    if n1<0
        error('error description �����������Ϊ0');
        return;
    else
        Sumsn =0;
        for i = 1:n1
            Sumsn = Sumsn+1/factorial(i);%���������Զ��庯���ļ�
        end
    
end