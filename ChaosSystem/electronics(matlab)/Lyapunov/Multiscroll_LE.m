function dX=Multiscroll_LE(t,X)
global a;
global b;
global c;
global d;
global n;
shitf = n/(2*b);
% shitf =6;%6个涡卷
% a=20;
% c=32;
% b=0.1;
x=X(1);
y=X(2);
z=X(3);
Y=[X(4),X(7),X(10);
   X(5),X(8),X(11);
   X(6),X(9),X(12)];
dX=zeros(12,1);
%%混沌系统方程
% if((x>shitf)||(x<-shitf))
%   fx=sin(2*pi*b*x);
% else
%   fx=-sin(2*pi*b*x);  
% end  
% fx=-sin(2*pi*b*x);  
% fx=-sin(2*pi*b*x).*[sign(x+shitf)-sign(x-shitf)-1];%正确
fx=-sin(2*pi*b*x).*[sign(x+shitf)-sign(x-shitf)-1];%正确 
dX(1)=50*y;
dX(2)=50*z;
dX(3)=50*[-a*y-c*z-d*fx];
%Jacobi矩阵
Jaco=[0,50,0;
      0,0,50;
      50*d*pi*2*b*cos(2*pi*b*x).*[sign(x+shitf)-sign(x-shitf)-1],-50*a,-50*c];
dX(4:12)=Jaco*Y;
end