%���巨�����������ŵ��ָ��
%��������data
%���ߣ��ź���
%ʱ�䣺2011��3��31������ʾ����
clear
global a;
global b;
global c;
global d;
global kn;
global kp;
global shitf_n;
global shitf_p;

b=0.25;
a=0.3;
c=0.3;
kn=3;
kp=3;

lya_pu=[];
sup_delt=1e-5;

lya_pu=[];
tic
% for r=1:1:500
% for r=10:1:280
x0=0;y0=0.1;z0=0.1;
y0=[0.1 0.1 0.1];
y1=[0.1+sup_delt 0.1+sup_delt 0.1+sup_delt];
tspan=0:(1*10^(-2)):200;
d0=norm([1+sup_delt 1+sup_delt 1+sup_delt]-[1 1 1]);

for d=0:0.01:0.5
[t,x]=ODE45('Jerk_Multiscroll',tspan,y0);%sim('lorenz_sim.mdl',50)
data1=[x(3000:end,1),x(3000:end,2),x(3000:end,3)];%����ȡǰһ���ֵ�����

[t,x]=ODE45('Jerk_Multiscroll',tspan,y1);
data2=[x(3000:end,1),x(3000:end,2),x(3000:end,3)];%����ȡǰһ���ֵ�����

data_temp=data1-data2;
lyap=[];
for i=1:length(data_temp(:,1))
    lyap(i)=norm(data_temp(1,:));
end

lya=sum(log(lyap./d0))/length(data_temp(:,1))/10;
lya_pu=[lya_pu,lya];
d
lya
end
toc

% r=[1:1:500];
d=[0:0.01:0.5];
figure
plot(d,lya_pu);