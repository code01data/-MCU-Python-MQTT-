%2020年3月19日

% function dX=lorenz_shiyu(t,X)
% global delt r b;
% 
% x=X(1);y=X(2);z=X(3);
% 
% %初始化
% dX=zeros(3,1);
% %lorenz系统方程
% dX(1)=-delt*(x-y);
% dX(2)=-x*z+r*x-y;
% dX(3)=x*y-b*z;


%====基于Jerk的多涡卷混沌系统======
%dx/dt=y;
%dy/dt=z;
%dz/dt=-a*x-b*y-c*z+f(x)

function dy=lorenz_shiyu(t,y)%function dy=Jerk_Multiscroll(t,y)

global a;
global b;
global c;
global d;
global nn;
global np;
global shitf_n;
global shitf_p;
dy=zeros(3,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fx=-sin(2*pi*b*y(1)).*[sign(y(1)+shitf_n)-sign(y(1)-shitf_p)-1];
fy=0;%单涡卷 
dy(1)=50*[y(2)];
dy(2)=50*y(3);
dy(3)=50*[-a*y(2)-c*y(3)-d*fx];%p=q=0,k=10的双涡卷

end