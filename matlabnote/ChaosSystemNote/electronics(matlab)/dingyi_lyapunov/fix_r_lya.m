%���巨�����������ŵ��ָ��
%��������data
%���ߣ��ź���
%ʱ�䣺2011��3��31����
clear
global delt r b; 
delt=10;
b=8/3;
lya_pu=[];
sup_delt=1e-5;


lya_pu=[];
tic
r=28
r
x0=1;y0=1;z0=1;
sim('lorenz_sim.mdl',100)


data1=[x(3000:end),y(3000:end),z(3000:end)];%����ȡǰһ���ֵ�����


x0=1+sup_delt+rand(length(data1),1)*0.1;y0=1+sup_delt+rand(length(data1),1)*0.1;z0=1+sup_delt+rand(length(data1),1)*0.1;
sim('lorenz_sim.mdl',100)

d0=norm([1+sup_delt 1+sup_delt 1+sup_delt]-[1 1 1]);
data2=[x(3000:end),y(3000:end),z(3000:end)];%����ȡǰһ���ֵ�����

data_temp=data1-data2;
d=[];
for i=1:length(data_temp(:,1))
    d(i)=norm(data_temp(1,:));
end

lya=sum(log(d./d0))/length(data_temp(:,1))/10;
lya_pu=[lya_pu,lya]


toc

