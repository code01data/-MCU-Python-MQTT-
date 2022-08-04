%定义法求最大李亚普诺夫指数
%输入数据data
%作者：张海龙
%时间：2011年3月31日晚演示程序
clear
global delt r b; 
delt=10;
b=8/3;
lya_pu=[];
sup_delt=1e-5;


lya_pu=[];
tic
% r=[1:1:500]
for r=10:1:280
r
% x0=1;y0=1;z0=1;
x0=0;y0=1;z0=1;  %与zhengjiao下的计算方法比较
sim('lorenz_sim.mdl',50)


data1=[x(3000:end),y(3000:end),z(3000:end)];%不能取前一部分的数据


x0=1+sup_delt;y0=1+sup_delt;z0=1+sup_delt;
sim('lorenz_sim.mdl',50)

d0=norm([1+sup_delt 1+sup_delt 1+sup_delt]-[1 1 1]);
data2=[x(3000:end),y(3000:end),z(3000:end)];%不能取前一部分的数据

data_temp=data1-data2;
d=[];
for i=1:length(data_temp(:,1))
    d(i)=norm(data_temp(1,:));
end

lya=sum(log(d./d0))/length(data_temp(:,1))/10;
lya_pu=[lya_pu,lya];

end
toc

% r=[1:1:500];
r=[10:1:280];
figure
plot(r,lya_pu);