%------------------------------------------------------------------------------------
%  1. 符号运算
%    limit(f,x,a)：求极限  x->a
%    limit(f,x,a,'left')：求左极限  x->a-
%    limit(f,x,a,'right')：求右极限 x->a+
%    diff(f,x,n)：求f关于变量x的n阶导数 
%    taylor(f,x,a,'Order',n)	：将函数f(x)在 处展为 
%    symsum(f,v,a,b)	：求f在指定变量v取遍[a,b]中所有整数时的和 
%    int(f,v)：给出f对指定变量v的（不带积分常数）的不定积分
%    int(f,v,a,b)：给出f对指定变量v在[a,b]区间上的定积分
%------------------------------------------------------------------------------------
% syms t s k  %使用指令syms x定义一个符号变量x。符号变量可以进行算数运算，积分等操作
syms t x k 
f1 = sin(k*t)/(k*t);
f2 = (1-1/x)^(k*x);
f3 = (pi/2-atan(x))/(1/x); %反三角函数atan asin acos

L1 = limit(f1,t,0) %inf 表示无穷大 %+inf 表示正无穷大 %-inf 表示负无穷大
L2 = limit(f2,x,inf)
L3 = limit(f3,x,+inf)


syms y
D1 = diff(log(cos(exp(y))))%默认求一阶导数
%D2 = diff('f(y^2)',y,2)


clear
syms x1 y1 z1
f1=x1*log(x1)
s1=int(f1,x1)    % int(f,v)：给出f对指定变量v的（不带积分常数）的不定积分
s1=simplify(s1)  %对表达式进行化简
s2=int(f1,'a','b')  % int(f,v,a,b)：给出f对指定变量v在[a,b]区间上的定积分
s3=int(f1,1,2)      % int(f,v,a,b)：给出f对指定变量v在[a,b]区间上的定积分
s4 = int(int(int(x1^2+y1^2+z1^2,z1,sqrt(x1*y1),x1^2*y1),y1,sqrt(x1),x1^2),x1,1,2)


clear all	
dsolve('D2y-4*Dy+13*y=0','y(0)=0','Dy(0)=3','x')
dsolve('D2y-5*Dy+6*y=x*exp(2*x)','x')






