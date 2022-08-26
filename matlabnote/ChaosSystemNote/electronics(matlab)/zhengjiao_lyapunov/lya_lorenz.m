%2020年3月20日
%计算李亚普诺夫指数谱wolf法，超混沌Lorenz系统，关于系数a
lp_lorenz_asym=zeros(1,3);
global a;
global b;
global c;
global d;
global nn;
global np;
global shitf_n;
global shitf_p;
b=0.25;%正弦函数的系数
a=0.3;%y(2)的系数.ok
c=0.3;%y(3)的系数
nn=3;
np=3;

shitf_n =nn/b;
shitf_p =np/b;
%d control
tic
for d=0:0.01:3;
    d
    [T,Res]=lyapunov(3,@lorenz,@ode45,0,0.5,200,[0.1 0.1 0.1],10); %原始的
%     [T,Res]=lyapunov(3,@lorenz,@ode45,0,0.01,100,[0 1 1],10);
    lp_lorenz_asym=[lp_lorenz_asym;Res(end,:)];
end
toc

lp_lorenz_asym(1,:)=[];
d=[0:0.01:3];
plot(d,lp_lorenz_asym(:,1),'-',d,lp_lorenz_asym(:,2),'-',d,lp_lorenz_asym(:,3),'-');
% title('李亚普诺夫指数谱（lorenz系统）')
xlabel('d');
ylabel('Lyapunov exponents');
grid on;

% % lorenz_asym_lyaDim=2+(lp_lorenz_asym(:,1)+lp_lorenz_asym(:,2))./abs(lp_lorenz_asym(:,3))  %分形维数（lyapunov维数）
% % figure;
% % plot(d,lorenz_asym_lyaDim);
% % title('The Lyapunov dimension of a 3-D chaotic system')
% % xlabel('parameter d'),
% % ylabel('Lyapunov dimension')
