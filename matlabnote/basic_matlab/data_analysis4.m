%--------------------------------------------------------------------------
%  第4.4章  多项式计算
%-------------------------------------------------------------------------- 


%多项式一般表达式 Pn(x) = p0+p1*x+p2*x^2+.....+pn*x^n
% MATLAB表示多项式为包含由下降幂排列的系数的行向量
% 例如 x^3-2*x^2+3x+4  p=[1 -2 3 4]

%disp(x)显示变量的值
%1.多项式计算
%加减法 (多项式的加减运算非常简单，即相应向量相加减 ,两个向量的大小必须相同，缺少的补0)

pnx1 = [1,-3,2,1];  % x^3-3*x^2+2x+1 
pnx2 = [5,-2,6,1];  % 5^x3-2*x^2+6x+1 

p1_p2 = pnx1 + pnx2;
p1_p2_ = pnx1 - pnx2;
%向量形式转换成符号多项式的形式
p1_p2 = poly2sym(p1_p2)
p1_p2_ = poly2sym(p1_p2_)

pnx3 = [2,0,4,1]; % 2*x^3+4x+1 
pnx4 = [1,-2,3,1]; % x^3-2*x^2+3x+1 

p3_p4 = pnx3 + pnx4;
p3_p4_ = pnx3 - pnx4;
%向量形式转换成符号多项式的形式
p3_p4 = poly2sym(p3_p4)
p3_p4_ = poly2sym(p3_p4_)

%乘法 conv() 卷积

pnx5 = [1,-3,2,1];  % x^3-3*x^2+2x+1 
pnx6 = [5,-2,6,1];  % 5^x3-2*x^2+6x+1 

p5_conv_p6 =  conv(pnx5,pnx6)
p5_conv_p6 = poly2sym(p5_conv_p6)

%除法 deconv()  []
%多项式除法: deconv. 对于任意两个多项式p1, p2, deconv(p1,p2)的值为两个行向量, 
%          即[q,r]=deconv(p1,p2), 其中q是p1除以p2的商, r是余, 它们满足p1=conv(p2,q)+r.
pnx7 = [1,-3,2,1];  % x^3-3*x^2+2x+1 
pnx8 = [5,-2,6,1];  % 5^x3-2*x^2+6x+1 

p7_conv_p8 =  conv(pnx7,pnx8)  %计算p7*p8
[p7_deconv_p8,r] = deconv(p7_conv_p8,pnx7 ) %计算p7*p8 /p7
P7_deconv_P8 = poly2sym(p7_deconv_p8) 


%2.多项式导数 ployder()
q1 = [3 0 -2 0 1 5];
q2 = [1 -2 0 0 11];
q3 = [1 -10 15];
a = [1 0 -3 0 -1];
b = [1 4];

m = polyder(q1)             %计算q1的导数
m_conv = polyder(q2,q3)     %计算conv(q1,q2)相乘的多项式的导数
[q,r1]= polyder(a,b)         %计算a,b相除的多项式的导数 []



%V=polyval(p,x)  按照数组的运算规则计算的多项式的值，计算多项式 p 在 x 的每个点处的值。x可以是矩阵，向量，标量，代表是自变量的数值。
%V=polyvalm(p,x) 按照矩阵的运算规则计算的多项式的值，计算矩阵整体而不是矩阵元素的计算，x必须是方阵。

px = [3 2 1];
x = [5 7 9];
y = polyval(px,x)

yint = polyint(px) %求不定积分
a1 = -1;
b1 = 3;
I = diff(polyval(yint,[a1 b1]))  %计算积分定积分 a1,b1上下限


%roots()多项式根

roots_px = [1,0,-1];
roots_x = roots(roots_px)


rt_px = [1 0 0 0 -1];
rt_x = roots(rt_px)


%polyeig多项式特征值问题
M = diag([3 1 3 1])
e =polyeig(M)  %e = polyeig(A0,A1,...,Ap) 返回 p 次多项式特征值问题的特征值。
%[X,e] = polyeig(A0,A1,...,Ap) 还会返回大小为 n×n*p 的矩阵 X，其列是特征值。


%polyfit()多项式曲线拟合
%p = polyfit(x,y,n) 返回次数为 n 的多项式 p(x) 的系数，该阶数是 y 中数据的最佳拟合(在最小二乘方式中)
fitx = linspace(0,4*pi,10);
fity = sin(fitx);

fitp = polyfit(fitx,fity,7);
fitx1 = linspace(0,4*pi);
fity1=  polyval(fitp, fitx1);
figure
plot(fitx,fity,'o')
hold on
plot(fitx1,fity1)
hold off
title('多项式曲线拟合');


%[p,S,mu] = polyfit(x,y,n)  
% p是多项式系数 S主要用与进行误差估计与预测数据结构体
% x,y 是输入的样本数据点 n表示拟合计算多项式的系数 mu是均值和标准差构成的1x2维的向量
%拟合数据x、y 
xm1 = [1 2 3 4 5]
ym1 = [5.5 43.1 128 290.7 498.4]
%用多项式拟合数据xm1和ym1
pm1 = polyfit(xm1,ym1,3);
%利用polyval函数计算拟合的多项式系数p在给定数据x处的y值
x1m1 = 1:0.1:5;
y1m1 = polyval(pm1,x1m1);
% 绘制曲线图
figure
plot(xm1,ym1,'o',x1m1,y1m1)
grid on
title('多项式曲线拟合');