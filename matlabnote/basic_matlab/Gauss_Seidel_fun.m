%{
    A: 线性方程组的系数矩阵（n*n，非奇异）
    b: 方程组右边的常数项列向量
    n: 方程组维数
    x0: 初始值向量
    tol: 精度上限值
    nmax:  最大迭代次数
    //迭代终止标准
    已达精度上限值或者到达最大迭代次数
    //输出量：
    x：线性方程组的解
%}


function [x,n] = Gauss_Seidel_fun(A,b,x0,nmax,tol)
    if nargin == 4;
        tol =  1.0e-6;
    elseif nargin == 3
        tol = 1.0e-6;
        nmax=500;
    elseif nargin == 2
        tol = 1.0e-6;
        nmax= 200;
        x0 = zeros(size(b))
    end

    n = length(b);
    if size(x0,1)<size(x0,2)
        x = x0';
    end

    x = x0;
    for k = 1:nmax
        x(1) = (b(1)-A(1,2:n)*x(2:n))/A(1,1);
        for m = 2:n-1
            t1 = b(m)-A(m,1:m-1)*x(1:m-1)-A(m,m+1:n)*x(m+1:n);
            x(m) = t1/A(m,m);
        end
        x(n) = (b(n)-A(n,1:n-1)*x(1:n-1))/A(n,n);
        if nargout == 0,
            x,
        end

        if norm(x - x0)/(norm(x0)+eps)<tol;
            break
        end

        x0 =x;

    end
disp('迭代次数：')
disp(n)
x = x';

end