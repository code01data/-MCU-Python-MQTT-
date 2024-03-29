% % function Jerk_Multiscroll_phase
%Jerk的多涡卷相图 

%==================================求特征根，特征方程 开始=========================
% clear;
% close all;
% global a;
% global b;
% global c;
% global d;
% 
% a=0.7;
% b=0.7;
% c=0.7;
% d=0.7;
% % syms d;
% d=0.7;
% A=[0,1,0;0,0,1;-d,-d,-d];
% [V,b]=eig(A);%求特征根和特征值
% lambda=diag(b);
% AA=sym(A);
% BB=poly(AA);%特征多项式
% cc=simple(BB); %化简特征多项式
%==================================求特征根，特征方程  结束=========================
%%=================Jerk系统相图  开始======================
%f(x)=|F(x)|sgn(x)-x,F(x)=5(sin1.27x)
clear;
close all;
format long
global a;
global b;
a=6;
% b=1.27;
b=0.25
kp=2;
kn=2;
x=-15:0.01:15;
ffx=-sin(2*pi*b*x).*(sign(x+kn/b)-sign(x-kp/b)-1);

plot(x,ffx,'black');
hold on;
plot(x,0,'black');
xlabel('x');
ylabel('f(x)');
hold on;
for i=0:4:4
    plot(i,0,'*');
    hold on;
end    
for i=10:4:15
    plot(i,0,'*');
    hold on;
end 

for i=2:4:6
    plot(i,0,'o');
    hold on;
end    
for i=12:4:15
    plot(i,0,'o');
    hold on;
end 
%===============================================
for i=0:-4:-4
    plot(i,0,'*');
    hold on;
end    
for i=-10:-4:-15
    plot(i,0,'*');
    hold on;
end 

for i=-2:-4:-6
    plot(i,0,'o');
    hold on;
end    
for i=-12:-4:-15
    plot(i,0,'o');
    hold on;
end 

% hold on;
% plot(x,abs(Fx));
% a=d*2*k/h1; 
% %-----------------饱和函数 >>>>>---------------------------
% y0=[0.1 0 0]; %初始状态,输入为sin(x)
% %------------------------------------------------------------------------
% tspan=0:(1*10^(-3)):400;
% [t,y]=ODE45('Jerk_Multiscroll',tspan,y0);
% % %-------------------图1--------------------------------
% figure(1);
% plot3(y(10000:end,1),y(10000:end,2),y(10000:end,3));
% % title('a=0.6,b=0.5,c=0.3,d=0.35');
% title('a=0.3,c=0.3,b=0.5,n=4,d=0.3');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% %-------------------图2 x-y 平面--------------------------------
% figure(2);
% plot(y(10000:end,1),y(10000:end,2));
% xlabel('x');
% ylabel('y');
% %%=================包混沌系统相图  结束======================

%%=========劳斯表计算  开始=================
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
%     plot(y(i,:),'r-');%劳斯表低1列系数
%   else 
%     plot(y(i,:),'b-*');%劳斯表低1列系数
%   end  
%   hold on;
%   i=i+1;
% end
% y1=[0,0,0,0];
% plot(y1,'r-');%绘制取值=0的曲线
%%=========劳斯表计算  结束=================
% % end
