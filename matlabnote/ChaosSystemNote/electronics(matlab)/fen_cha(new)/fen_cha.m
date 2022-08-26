%计算lorenz系统分岔图，采用ode45变步长
%2011年3月26日晨
% global delt r b; 
% delt=10;
% b=8/3;
% r_test=[10:1:280];
% % r_test=[1:1:500];
% data_x=[];
% data_y=[];
% data_z=[];
% tau1=[];
% tau2=[];
% tau3=[];
% t0=[0 100];
% tic
% for i=1:length(r_test)
%     r=r_test(i)  %r的变化精度
% %     [t,y]=ode45(@lorenz_shiyu,t0,[1,1,1]);
%      [t,y]=ode45(@lorenz_shiyu,t0,[0,1,1]);
%     [Xmax]=getmax(y(:,1));
%     plot(r,Xmax,'b','markersize',1)
%     hold on
%     clear Xmax
% end
% xlabel('r');
% ylabel('x');
% toc

global a;
global b;
global c;
global d;
global nn;
global np;
global shitf_n;
global shitf_p;

b=0.25;

a=0.3;
c=0.3;
nn=3;
np=3;
shitf_n = nn/b;
shitf_p =np/b;
r_test=[0.1:0.1:10];
% r_test=[1:1:500];
data_x=[];
data_y=[];
data_z=[];
tau1=[];
tau2=[];
tau3=[];
% t0=[0 100];
t0=0:10^(-2):200;
tic
% for i=1:length(r_test)
    for i=1:300
%     d=r_test(i)  %r的变化精度
     d=0.01*i
%     [t,y]=ode45(@lorenz_shiyu,t0,[1,1,1]);
     [t,y]=ode45(@lorenz_shiyu,t0,[0.1,0.1,0.1]);
%      [Xmax]=getmax(y(10000:end,1));
     y1=y(10001:20001,1);
     [Xmax]=getmax(y1);
%     [Xmax]=getmax(y(1:20000,1));
    plot(d,Xmax,'b','markersize',5)
    hold on
    clear Xmax
end
xlabel('d');
ylabel('x max');
toc

