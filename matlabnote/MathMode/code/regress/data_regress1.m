%{
[B,BINT,R,RINT,STATS] = regress(Y,X)
[B,BINT,R,RINT,STATS] = regress(Y,X,ALPHA)
�������ͣ�
    B��     �ع�ϵ�����Ǹ���������the vector B of regression coefficients in the  linear model Y = X*B������
    BINT��  �ع�ϵ����������ƣ���a matrix BINT of 95% confidence intervals for B������
    R��     �в ��a vector R of residuals������
    RINT��  �������䣨��a matrix RINT of intervals that can be used to diagnose outliers������
    STATS�� ���ڼ���ع�ģ�͵�ͳ��������4����ֵ���ж�ϵ��R^2��Fͳ�����۲�ֵ�������p��ֵ������Ĺ��ơ�
    ALPHA�� ������ˮƽ��ȱ��ʱΪĬ��ֵ0.05��
%}



%��������  
y=[7613.51  7850.91  8381.86  9142.81 10813.6 8631.43 8124.94 9429.79 10230.81 10163.61 9737.56 8561.06 7781.82 7110.97]';  
x1=[7666 7704 8148 8571 8679 7704 6471 5870 5289 3815 3335 2927 2758 2591]';  
x2=[16.22 16.85 17.93 17.28 17.23 17 19 18.22 16.3 13.37 11.62 10.36 9.83 9.25]';  
X=[ones(size(y)), x1.^2,x2.^2, x1, x2, x1.*x2];  
%��ʼ����  
[b,bint,r,rint,stats] = regress(y,X)

figure
subplot(2, 1, 1)
plot(x1,y,'r*')
subplot(2, 1, 2)
plot(x2,y,'b+')



