  %  �����Է������sor(successive over-relaxation)�����������ø�ʽΪ
    %  [x, n] = sor(A,b,x,w,it_max)
    %  ����, A Ϊ���Է������ϵ������wΪȨ��ֵ(��������)��b Ϊ������
    %  tol Ԥ������
    %  x0: ��ʼֵ����
    %  x Ϊ���Է�����Ľ⣬n-1Ϊ��������


function [x,k] = SOR(A,b,x0,w,tol)

    max =300; 
    if(w<=0||w>=2)
        error;
        return;
    end

D = diag(diag(A));%��A�ĶԽǾ���
L = tril(A,-1);%��A�������Ǿ���
U = triu(A,1);%��A�������Ǿ���
B = inv(D-w.*L)*((1-w).*D+w.*U);
f = w.*inv((D-w.*L))*b;

x = B*x0 +f;
k =1;
while norm(x-x0)>=tol
    x0 = x;
    x = B*x0 +f;
    k = k+1;
    if(k>=max)
        disp('Warning:��������̫�࣬���ܲ�����')
        return
    end
end

end
    