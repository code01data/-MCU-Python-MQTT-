%2020年3月20日
%三维lorenz系统
function dX=lorenz(t,X)
global a;
global b;
global c;
global d;
global nn;
global np;
global shitf_n;
global shitf_p;

x=X(1);y=X(2);z=X(3);
fx=-sin(2*pi*b*x).*[sign(x+shitf_n)-sign(x-shitf_p)-1];
%
Y=[X(4),X(7),X(10);
    X(5),X(8),X(11);
    X(6),X(9),X(12)];
%初始化
dX=zeros(12,1);

dX(1)=50*y;
dX(2)=50*z;
dX(3)=50*(-a*y-c*z-d*fx);%p=q=0,k=10的双涡卷
%lorenz系统的雅可比矩阵
Jaco=[0,50,0;
      0,0,50;
      50*d*pi*2*b*cos(2*pi*b*x).*[sign(x+shitf_n)-sign(x-shitf_p)-1],-50*a,-50*c];
dX(4:12)=Jaco*Y;