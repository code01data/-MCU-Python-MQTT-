%{
[B,BINT,R,RINT,STATS] = regress(Y,X)
[B,BINT,R,RINT,STATS] = regress(Y,X,ALPHA)
参数解释：
    B：     回归系数，是个向量（“the vector B of regression coefficients in the  linear model Y = X*B”）。
    BINT：  回归系数的区间估计（“a matrix BINT of 95% confidence intervals for B”）。
    R：     残差（ “a vector R of residuals”）。
    RINT：  置信区间（“a matrix RINT of intervals that can be used to diagnose outliers”）。
    STATS： 用于检验回归模型的统计量。有4个数值：判定系数R^2，F统计量观测值，检验的p的值，误差方差的估计。
    ALPHA： 显著性水平（缺少时为默认值0.05）
%}



%导入数据  
y=[7613.51  7850.91  8381.86  9142.81 10813.6 8631.43 8124.94 9429.79 10230.81 10163.61 9737.56 8561.06 7781.82 7110.97]';  
x1=[7666 7704 8148 8571 8679 7704 6471 5870 5289 3815 3335 2927 2758 2591]';  
x2=[16.22 16.85 17.93 17.28 17.23 17 19 18.22 16.3 13.37 11.62 10.36 9.83 9.25]';  
X=[ones(size(y)), x1.^2,x2.^2, x1, x2, x1.*x2];  
%开始分析  
[b,bint,r,rint,stats] = regress(y,X)

figure
subplot(2, 1, 1)
plot(x1,y,'r*')
subplot(2, 1, 2)
plot(x2,y,'b+')



