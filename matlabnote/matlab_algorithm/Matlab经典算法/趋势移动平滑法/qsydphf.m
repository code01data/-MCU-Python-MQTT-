%  qsydphf.m
clc,clear 
load y.txt   %��ԭʼ���ݱ����ڴ��ı��ļ� y.txt�� 
m1=length(y);    
n=6;   %nΪ�ƶ�ƽ�������� 
for i=1:m1-n+1 
    yhat1(i)=sum(y(i:i+n-1))/n; 
end 
yhat1 
m2=length(yhat1); 
for i=1:m2-n+1 
    yhat2(i)=sum(yhat1(i:i+n-1))/n; 
end 
yhat2   
plot(1:21,y,'*') 
a21=2*yhat1(end)-yhat2(end) 
b21=2*(yhat1(end)-yhat2(end))/(n-1) 
y1986=a21+b21 
y1987=a21+2*b21