%定义法求最大李亚普诺夫指数
%输入数据data
%作者：张海龙
%时间：2011年3月31日晚
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


data1=[x(3000:end),y(3000:end),z(3000:end)];%不能取前一部分的数据


x0=1+sup_delt+rand(length(data1),1)*0.1;y0=1+sup_delt+rand(length(data1),1)*0.1;z0=1+sup_delt+rand(length(data1),1)*0.1;
sim('lorenz_sim.mdl',100)

d0=norm([1+sup_delt 1+sup_delt 1+sup_delt]-[1 1 1]);
data2=[x(3000:end),y(3000:end),z(3000:end)];%不能取前一部分的数据

data_temp=data1-data2;
d=[];
for i=1:length(data_temp(:,1))
    d(i)=norm(data_temp(1,:));
end

lya=sum(log(d./d0))/length(data_temp(:,1))/10;
lya_pu=[lya_pu,lya]


toc

