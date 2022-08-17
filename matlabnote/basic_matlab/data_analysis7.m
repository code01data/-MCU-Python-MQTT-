%--------------------------------------------------------------------------
%  第4.7章  数值积分，数值微分
%-------------------------------------------------------------------------- 

%{
q = integral(fun,xmin,xmax)
q = integral(fun,xmin,xmax,Name,Value)


q = integral(fun,xmin,xmax) 使用全局自适应积分和默认误差容限在 xmin 至 xmax 间以数值形式为函数 fun 求积分。
q = integral(fun,xmin,xmax,Name,Value) 指定具有一个或多个 Name,Value 对组参数的其他选项。
例如，指定 'WayPoints'，后跟实数或复数向量，为要使用的积分器指示特定点。


在matlab中有2类积分函数：
 
一、int()函数(解析解，速度慢) 符号积分
       int(f)   对函数f求不定积分
       int(f,v)     对函数f，关于变量v求不定积分
       int(f,a,b)       对函数f，求(a,b)上的定积分
       int(d,v,a,b)     对函数f，关于变量v求(a,b)上的定积分
       int(int(f,x,xmin,xmax),y,ymin,ymax)      二重积分解析解，先对x求，再对y求
       int(int(int(f,x,xmin,xmax),y,ymin,ymax)z,zmin,zmax)     三重积分解析解，先对x求，再对y求，再对z求
       
 
       
二、quad()函数和quadl()函数(求数值解，速度快，只能求定积分) 数值积分
       quad(f,a,b)      利用Simpson求积公式(低精度不光滑函数)，对函数f，求(a,b)上的定积分
       quadl(f,a,b)     利用Lobatto求积公式(高精度光滑函数)，对函数f，求(a,b)上的定积分
       dblquad(f,xmin,xmax,yxin,ymax)       二重积分，先对x再对y
       triplequad(f,xmin,xmax,yxin,ymax,zmin,zmax)        三重积分，先对x再对y再对z
 
    q = quadl(fun,a,b)
    q = quadl(fun,a,b,tol)
    quadl(fun,a,b,tol,trace)
    [q,fcnt] = quadl(...) 

    q = quadl(fun,a,b) 使用递归自适应 Lobatto 积分法求取函数 fun 从 a 到 b 的积分，误差小于 10-6。
    fun 是函数句柄。它接受向量 x 并返回向量 y，即在每个 x 元素处计算的函数 fun。范围 a 和 b 必须是有限的。
    参数化函数解释了如何为函数 fun 提供其他参数（如果需要）。
    q = quadl(fun,a,b,tol) 使用绝对误差容限 tol 代替默认值 1.0e-6。tol 值越大，函数计算量越少并且计算速度加快，但结果不太精确。
    具有非零 trace 的 quadl(fun,a,b,tol,trace) 在递归期间显示 [fcnt a b-a q] 的值。
    [q,fcnt] = quadl(...) 返回函数计算数。
    在 fun 的定义中使用数组运算符 .*、./ 和 .^，这样可以通过向量参数计算该函数。
    函数 quad 可能更有效，但被积函数精确度较低并且不均匀。
%}

%积分0,2的积分
fun = @(x,c) 1./(x.^3-2*x-c);  %匿名函数的定义
q = integral(@(x) fun(x,5),0,2)

%广义积分
fun2 = @(y) exp(-y.^2).*log(y).^2;
qf = integral(fun2,0,Inf)

%quad()函数和quadl()函数(求数值解，速度快，只能求定积分) 数值积分
%q = quadl(fun,a,b) 使用递归自适应 Lobatto 积分法求取函数 fun 从 a 到 b 的积分，误差小于 10-6。
%q = quad(fun,a,b) 使用递归自适应 Lobatto 积分法求取函数 fun 从 a 到 b 的积分，误差小于 10-6。
%积分 不同的表达方式
g=inline('exp(-x.^2)'); %在matlab命令窗口、程序或函数中创建局部函数时，可用inline
z=quadl(g,-1,1) 
z1=quad(g,-1,1) 

fun3=@(x) exp(-x.^2); %基本数学函数的表达式
zfun=quadl(fun3,-1,1)
zfun1=quad(fun3,-1,1)


%{
数值微分的实现：计算数值微分就是计算f(x)在给定点x的导数
方法一：
       利用多项式函数p(x)对f(x)进行逼近，然后再使用近似函数p(x)在给定x的导数作为f(X)的导数
方法二：
MATLAB提供了求 向前差分的函数diff，其调用格式有三种:
（1）dx=diff(x): 计算向量x的一阶向前差分,dx(i)=x(i+1)-x(i)，i=1，2，…，n-1。n是向量x的元素的个数
（2）dx=diff(x,n): 计算向量x的n阶向前差分。例如，diff(x,2)=diff(diff(x)）：x的二阶差分等于x的一阶差分再求一阶差分
（3）dx=diff(A,n,dim): 计算矩阵A的n阶差分，dim=1时（默认状态)按列计算差分;dim=2，按行计算差分。
 注意：dff函数计算的是向量元素间的差分，故差分向量元素的个数比原向量少了一个；
 同样对于矩阵来说差分后的矩阵比原矩阵少了一行或一列。另外计算差分之后，可以用f(x)在某点处的差商作为其导数的近以值。      
%}
% 数据准备
x1 = 0:0.3:4; 
y1 = cos(x1)+sin(x1);  %使用diff函数近似求函数的微分
% y的前向差分
Y1 = diff(y1); 
% x的前向差分
X1 = diff(x1); 
% 函数y=f(x)的微分近似
dy = Y1./X1 

%dy =
% 0.8362    0.4637    0.0499   -0.3685   -0.7539   -1.0720   -1.2943   -1.4010   -1.3825   -1.2406   -0.9878   -0.6468   -0.2481

x2 = 0:0.3:4; 
y2 = cos(x2)+sin(x2);  
p = polyfit(x2, y2, 5)% 多项式拟合polyfit(x, y, n)   n表示n次多项式 
dp = polyder(p)      % polyder 对于拟合多项式求导数
dpx = polyval(dp, pi) %  polyval 计算在pi出的值   V=polyval(p,x)  按照数组的运算规则计算的多项式的值  


%{
p =
   -0.0092    0.1092   -0.2873   -0.4010    0.9706    1.0008
dp =
   -0.0462    0.4370   -0.8618   -0.8021    0.9706
dpx =
   -1.0037
%}
