  %  求线性方程组的sor(successive over-relaxation)迭代法，调用格式为
    %  [x, n] = sor(A,b,x,w,it_max)
    %  其中, A 为线性方程组的系数矩阵，w为权重值(修正参数)，b 为常数项
    %  tol 预定进度
    %  x0: 初始值向量
    %  x 为线性方程组的解，n-1为迭代次数


function [x,k] = SOR(A,b,x0,w,tol)

    max =300; 
    if(w<=0||w>=2)
        error;
        return;
    end

D = diag(diag(A));%求A的对角矩阵
L = tril(A,-1);%求A的下三角矩阵
U = triu(A,1);%求A的上三角矩阵
B = inv(D-w.*L)*((1-w).*D+w.*U);
f = w.*inv((D-w.*L))*b;

x = B*x0 +f;
k =1;
while norm(x-x0)>=tol
    x0 = x;
    x = B*x0 +f;
    k = k+1;
    if(k>=max)
        disp('Warning:迭代次数太多，可能不收敛')
        return
    end
end

end
    