% % function Jerk_Multiscroll_phase
%Jerk�Ķ��о���ͼ 

%==================================������������������ ��ʼ=========================
clear;
close all;
format long
global a;
global b;
global c;
global d;
global nn;
global np;
global shitf_n;
global shitf_p;

b=0.5;%���Һ�����ϵ��

a=0.3;%y(2)��ϵ��.ok
c=0.3;%y(3)��ϵ��
% d=0.3;

% a=set_v;%y(2)��ϵ��.ok
% c=set_v;%y(3)��ϵ��
set_v=0.5;
d=set_v;

%d=0.2    %Ч����
% d=0.5  %Ч����
%=======================================
%����ѡ��
%  np=3;nn=0; y0=[0.1 0.1 0.1];plot(y(50000:end,1),y(50000:end,2));tspan=0:(1*10^(-2)):600;
%  np=0;nn=3; y0=[-0.1 0.1 0.1];plot(y(50000:end,1),y(50000:end,2));tspan=0:(1*10^(-2)):600;
%  np=5;nn=-2; y0=[10 0.1 0.1];plot(y(50000:end,1),y(50000:end,2));tspan=0:(1*10^(-2)):600;
%  np=-2;nn=5; y0=[-9 0.1  0.1];plot(y(50000:end,1),y(50000:end,2));tspan=0:(1*10^(-2)):600;
%  np=5;nn=-2;x0=1,2,4,5
%  np=-2;nn=5; y0=[-9 0.1 0.1];plot(y(50000:end,1),y(50000:end,2));tspan=0:(1*10^(-2)):600;
%  np=5;nn=-1; y0=[5 0.5 0.1];plot(y(50000:end,1),y(50000:end,2));tspan=0:(1*10^(-2)):600;
np=3;
nn=3;
%=======================================
shitf_n=nn/b;
shitf_p=np/b;

y0=[0.1 0.1 0.1]; %��ʼ״̬,����Ϊsin(x)
%------------------------------------------------------------------------
tspan=0:(1*10^(-2)):300;
[t,y]=ODE45('Jerk_Multiscroll',tspan,y0);
% % %-------------------ͼ1--------------------------------
% figure(1);
% plot3(y(10000:end,1),y(10000:end,2),y(10000:end,3));
% % title('a=0.6,b=0.5,c=0.3,d=0.35');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% grid on;
%-------------------ͼ2 x-y ƽ��--------------------------------
figure(2);
plot(y(10000:end,1),y(10000:end,2));
% title('a=0.3,c=0.3,b=0.5,n=4,d=0.3');
% hold on;
xlabel('x');
ylabel('y');
grid on;
% % 
% % % % %-------------------ͼ3  x-zƽ��--------------------------------
% % % % subplot(1,2);
% figure(3);
% plot(y(10000:end,1),y(10000:end,3));
% xlabel('x');
% ylabel('z');
% grid on;
% 
% % % % %-------------------ͼ4  y-zƽ��--------------------------------
% figure(4);
% plot(y(10000:end,2),y(10000:end,3));
% xlabel('y');
% ylabel('z');
% grid on;
% % % % %-------------------ͼ5--------4------------------------
% figure(5);
% plot(t(10000:end),y(10000:end,1));
% xlabel('t');
% ylabel('x');
% grid on;
% %%=================������ϵͳ��ͼ  ����======================

%%=========��˹������  ��ʼ=================
% clear;
% close all;
% a=20;
% b=20;
% c=40;
% x(1)=1;
% x(2)=(b+c-a);
% x(3)=b*c-a*b;
% x(4)=2*a*b*c;
% figure(1);
% i=1;
% for a=12:20
%   x(2)=(b+c-a);
%   x(3)=b*c-a*b;
%   x(4)=2*a*b*c;
%   y(i,:)=routh(x);
%   if(a==20)
%     plot(y(i,:),'r-');%��˹����1��ϵ��
%   else 
%     plot(y(i,:),'b-*');%��˹����1��ϵ��
%   end  
%   hold on;
%   i=i+1;
% end
% y1=[0,0,0,0];
% plot(y1,'r-');%����ȡֵ=0������
%%=========��˹������  ����=================
% % end