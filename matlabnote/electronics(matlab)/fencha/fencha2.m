%p232task1
%������ֲ� ���õ�����ʽx(k+1)=��sin(pi*x(k))��������Ӧ��Feigenbaumͼ��
clc,clear
y=@(k,x)k*sin(pi*x);
x0=0.3;
for k=0.5:0.01:2
    for i=1:300
        x0=y(k,x0);
        if i>150
            plot(k,x0,'.r')
            hold on;
        end
   end
end
grid