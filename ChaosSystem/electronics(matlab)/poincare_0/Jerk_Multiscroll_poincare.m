%������ϵͳ���Ӽ���ӳ��
% function bao1_poincare
clear;
close all;
format long;
global a;
global b;
global c;
dt=0.001;
% tspan=(0:dt:50);
tspan=(0:dt:1000);
% Y0=[10 10 10];
Y0=[0.1 0.1 0.1];
   b=4;%     b=0.015*(i-1);
    [T,Y]=ode45(@Jerk_Multiscroll,tspan,Y0);
    s=Y(1000:end,:);
    aa=0;%aa=1;
    bb=0;
    cc=1;%cc=0
%     p=-32;%p=-32;%%ƽ�淽�̣�ax+by+cz+p=0;
    p=0;
    func=((aa*s(:,1))+(bb*s(:,2))+(cc*s(:,3))+p)>0; %�ñ��ʽΪ��ʱ=1��Ϊ��ʱ=0
    %ȡ������ֵ����0������һ�ε�ֵС��0��
    func_n=(func(1:end-1)>0)&(xor(func(1:end-1),func(2:end)));%xorΪ���
    m=find(func_n==1); %ȡ��fun_n==1���±�
    %���溯���Ĺ����ǣ�����ƽ������ڵ�Ϊm,m+1,��ȡm��ĺ���ֵ/���ڵ㺯��ֵ�Ĳ�ֵ
    t_intsec=-(aa*s(m,1)+bb*s(m,2)+cc*s(m,3)+p)./(aa*(s(m+1,1)-s(m,1))+bb*(s(m+1,2)-s(m,2))+cc*(s(m+1,3)-s(m,3)));
    %����ķֲ��ֵ
    x_map=s(m,1)+(s(m+1,1)-s(m,1)).*t_intsec; %����ͨ����������꣺x
    y_map=s(m,2)+(s(m+1,2)-s(m,2)).*t_intsec; %����ͨ�����������:y
    z_map=s(m,3)+(s(m+1,3)-s(m,3)).*t_intsec; %����ͨ�����������:z
%     H=plot(b*ones(size(s(m,1))),x_map);
    H=plot(x_map,y_map);
    title('�Ӽ���ӳ��ͼ��a=c=0.3,b=0.25,d=0.3,z=0');
    xlabel('x');
    ylabel('y');
    set(H,'linestyle','none','marker','.','markersize',1);
    hold on;
    drawnow;

    