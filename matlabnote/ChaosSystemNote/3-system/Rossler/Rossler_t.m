function dX=Rossler_t(t,X)
    global a; % �����������������

    global b;
    
    global c;
    
   % a = 0.2;b=0.2; c=5.7;   %�����·����
    a = 0.35;b=0.4; c=4.9;  
    x=X(1); y=X(2); z=X(3);
    
    % Y������������Ϊ�໥�����ĵ�λ����
    
    % ��������ĳ�ʼ��
    
    dX = zeros(3,1);
    
    % Lorenz������
    
    dX(1)=-y-z;
    
    dX(2)=x+a*y;
    
    dX(3)=b+z*(x-c);
    
end