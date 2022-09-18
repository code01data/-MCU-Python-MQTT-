clc,clear 

% 加载数据，绘制时间序列图，
t = [1976:1987];
yt = load('dianqi.txt')        %原始数据以列向量的方式存放在纯文本文件中

figure(1)
plot(t,yt,'b*');
set(get(gca, 'Title'), 'String', '1976-1987年电器销售额 时间序列图');

%计算数据的长度(个数)
n=length(yt);  
 %不同的加权系数
alpha=[0.2 0.5 0.8]; 
%不同的加权系数的个数   对于不同的加权个数，进行不同预测
m=length(alpha);  
%初值 对于少于20个数据，一般选择最初几期实际值的平均值作为初始值
yhat(1,1:m)=(yt(1)+yt(2))/2;       
 
for i=2:n
    yhat(i,:)=alpha*yt(i-1)+(1-alpha).*yhat(i-1,:);
end

yhat   %一次指数平滑预测值

%计算标准误差  实际数据与一次指数平滑   % mean平均值函数  repmat 重复操作
 % repmat(yt,1,m)    把yt的内容复制到1*m的矩阵中 ，矩阵的每个元素都是yt
err = sqrt(mean((repmat(yt,1,m)-yhat).^2))      %误差 sqrt(mean((yt-yhat).^2)) 开方(平均值[(实际值 -预测值）.^2])

  
%把数据写入到excel文件中
xlswrite('dianqi.xls',yhat)  

%预测1988年的销售额
yhat1988=alpha*yt(n)+(1-alpha).*yhat(n,:)   