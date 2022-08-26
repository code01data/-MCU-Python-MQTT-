clear;
close all;
global a;
global b;
global c;
global d;
global n ; %n为涡卷的个数

a=0.3;
c=0.3;
b=0.25;
n=4;

y0=[0.1 0.1 0.1]; %初始状态,输入为sin(x)
tspan=0:(1*10^(-2)):200;
  CountTime=20;%计算次数
  figure(1);
  for m=1:35
      d=m*0.03;
      [t,y]=ode45('Jerk_Multiscroll',tspan,y0);
       plot(d,y(19000:end,1),'.black');
       hold on;
  end  
  xlabel('d');
  ylabel('x');
%     for m=1:CountTime
%         d=0.03*m;
%         [t,y]=ODE45('Jerk_Multiscroll',tspan,y0);
%         datanum=length(t);
%           for i=10000:datanum
%              plot(d,y(i:end,1),'.b');
%           end
%           hold on;
%      end     
% % clc,clear
% % y=@(k,x)1-k*x^2;
% % x0=0;
% % figure(2);
% % for k=0.01:0.005:1.99
% %     for i=1:300
% %         x0=y(k,x0);
% %         if i>10
% %               plot(k,x0,'.b')
% %               hold on;
% %         end
% %    end
% % end
% % grid