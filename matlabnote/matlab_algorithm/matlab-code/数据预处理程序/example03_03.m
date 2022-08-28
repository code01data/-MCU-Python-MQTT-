%--------------------------------------------------------------------------
%              调用medfilt1函数对加噪正弦波信号进行平滑处理
%--------------------------------------------------------------------------

%*****************产生加噪正弦波信号，绘制加噪波形图*************************
t = linspace(0,2*pi,500)';  % 产生一个从0到2*pi的向量，长度为500
y = 100*sin(t);  % 产生正弦波信号
% 产生500行1列的服从N(0,152)分布的随机数，作为噪声信号
noise = normrnd(0,15,500,1);
y = y + noise;  % 将正弦波信号加入噪声信号
figure;  % 新建一个图形窗口
plot(t,y);  % 绘制加噪波形图
xlabel('t');  % 为X轴加标签
ylabel('y = sin(t) + 噪声');  % 为Y轴加标签


%***********调用medfilt1对加噪正弦波信号y进行中值滤波，并绘制波形图***********
yy = medfilt1(y,30);  % 指定窗宽为30，对y进行中值滤波
figure;  % 新建一个图形窗口
plot(t,y,'k:');  % 绘制加噪波形图
hold on
plot(t,yy,'k','LineWidth',3);  % 绘制平滑后曲线图，黑色实线，线宽为3
xlabel('t');  % 为X轴加标签
ylabel('中值滤波');  % 为Y轴加标签
legend('加噪波形','平滑后波形');