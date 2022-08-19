%无约束条件的非线性规划(题目见--优化算法-非线性规划.md)
%绘制图像
f3x = linspace(-pi, pi);
y3x = abs(1./(f3x));
plot(f3x, y3x,'ro');
set(get(gca, 'Title'), 'String', 'y = 1/abs(x) 图像');
grid on

x3_0 =1;%初值
x3_1 =-3;
x3_2 =1;
[x1,fval1,exitflag] = fminbnd(@fun3, x3_1, x3_2) %在x3_1~x3_2之间的最值
%fminunc函数优化成功，但解是错误的（fminunc的目标函数必须是连续函数，本例目标函数不连续）
[x2,fval2,exitflag] = fminunc(@fun3, x3_0)
%fminsearch函数优化失败，因为该函数只能求解多变量目标函数。
[x3,fval3,exitflag] = fminsearch(@fun3, x3_0)