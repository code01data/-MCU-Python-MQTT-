%{
    A: ���Է������ϵ������n*n�������죩
    b: �������ұߵĳ�����������
    n: ������ά��
    x0: ��ʼֵ����
    tol: ��������ֵ
    nmax:  ����������
    //������ֹ��׼
    �Ѵﾫ������ֵ���ߵ�������������
    //�������
    x�����Է�����Ľ�
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
disp('����������')
disp(n)
x = x';

end