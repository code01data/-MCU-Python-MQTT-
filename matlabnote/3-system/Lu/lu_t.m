function dX=chen_t(t,X)
    global a; % �����������������

    global b;
    
    global c;
    
    a = 36;b=3; c=20;
    x=X(1); y=X(2); z=X(3);
    
    % Y������������Ϊ�໥�����ĵ�λ����
    
    % ��������ĳ�ʼ��
    
    dX = zeros(3,1);
    
    % Lorenz������
    
    dX(1)=a*(y-x);
    
    dX(2)=c*y-x*z;
    
    dX(3)=x*y-b*z;
    
end