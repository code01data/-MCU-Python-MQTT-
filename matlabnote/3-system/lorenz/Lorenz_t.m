function dX=Lorenz_t(t,X)
    global a; % �����������������

    global b;
    
    global c;
    
    a = 10;b=8/3; c=28;
    x=X(1); y=X(2); z=X(3);
    
    % Y������������Ϊ�໥�����ĵ�λ����
    
    % ��������ĳ�ʼ��
    
    dX = zeros(3,1);
    
    % Lorenz������
    
    dX(1)=a*(y-x);
    
    dX(2)=x*(c-z)-y;
    
    dX(3)=x*y-b*z;
    
end