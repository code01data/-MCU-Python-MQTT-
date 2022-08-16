%{
    A: 线性方程组的系数矩阵（n*n，非奇异）
    b: 方程组右边的常数项列向量
    n: 方程组维数
    x0: 初始值向量
    eps: 精度上限值
    M:  最大迭代次数
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
        disp('Warning:迭代次数太多，可能不收敛')
        return
    end
end
disp('迭代次数：')
disp(n)

end