%2011年3月
%计算李亚普诺夫指数谱wolf法，超混沌Lorenz系统，固定系数r
lp_lorenz_asym=zeros(1,3);
global delt r b; 
delt=10;
b=8/3;
tic
r=28
    [T,Res]=lyapunov(3,@lorenz,@ode45,0,0.5,200,[0 1 1],10);
    lp_lorenz_asym=[lp_lorenz_asym;Res(end,:)];
toc

lp_lorenz_asym(1,:)=[];
r=[10:1:280];
plot(r,lp_lorenz_asym(:,1),'-',r,lp_lorenz_asym(:,2),'-',r,lp_lorenz_asym(:,3),'-');
title('李亚普诺夫指数谱（lorenz系统）')
xlabel('a'),
ylabel('李亚普诺夫指数')
grid on