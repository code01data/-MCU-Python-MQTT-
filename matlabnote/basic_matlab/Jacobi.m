%{
    A: ���Է������ϵ������n*n�������죩
    b: �������ұߵĳ�����������
    n: ������ά��
    x0: ��ʼֵ����
    eps: ��������ֵ
    M:  ����������
%}
    


function [x,n] = Jacobi(A,b,x0,eps,M)
    if nargin < 3;
        error
        return ;
    elseif nargin == 3
        eps = 1.0e-4;
        M=200;
    elseif nargin == 4
        M=200;
end

D = diag(diag(A));
L = -tril(A,-1);
U = -triu(A,1);
B = D\(L+U);
f = D\b;
x = B*x0 +f;
n = 1;
while norm(x-x0)>eps
    x0 = x;
    
    n = n+1;
    if(n>=M)
        disp('Warning:��������̫�࣬���ܲ�����')
        return
    end
end
disp('����������')
disp(n)

end