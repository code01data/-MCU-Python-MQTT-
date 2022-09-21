clearvars; close all; %清空工作环境
%导入数据，第一列为触角长度，第二列为翅膀长度
x_1 = [1.24, 1.72; 1.36, 1.74; 1.38, 1.64; 1.38, 1.82;
    1.38, 1.90; 1.40, 1.70; 1.48, 1.82; 1.54, 1.82; 1.56, 2.08]; %Af蠓虫
x_2 = [1.14, 1.78; 1.18, 1.96; 1.20, 1.86; 1.26, 2.00; 1.28, 2.00;
    1.30, 1.96]; %Apf蠓虫
x = [x_1; x_2]'; %合并转置，因为feedforwardnet函数以一列为单个样本

goal = [ones(1, 9), zeros(1, 6); zeros(1, 9), ones(1, 6)]; %(1,0)表示为
%Af蠓虫，(0,1)表示Apf蠓虫
x_recognize = [1.24, 1.80; 1.28, 1.84; 1.40, 2.04]'; %识别的样本

plot(x_1(:, 1), x_1(:, 2), 'ro', 'DisplayName', 'Af'); %绘制Af的散点图
hold on;
plot(x_2(:, 1), x_2(:, 2), 'bo', 'DisplayName', 'Apf'); %绘制Apf的散点图
plot(x_recognize(1, :), x_recognize(2, :), 'yo', 'DisplayName', '识别' ); %绘制识别样本的散点图
xlabel('触角长度');
ylabel('翅膀长度');
legend;

net = feedforwardnet([3, 2], 'trainlm'); %两层隐含层，相应神经元个数分别为3和2，采用L-M优化算法，效果比较好
net.trainParam.max_fail = 1000;
net.trainParam.lr = 0.05; %学习速率
net.trainParam.epochs = 10000; %最大训练次数
net.trainParam.goal = 1e-15; %最小误差，达到该精度，停止训练
net.trainParam.show = 50; %每50次展示训练结果
net = train(net, x, goal); %训练
y0 = sim(net, x) %输出
perf = perform(net, goal, y0)%误差
ym = sim(net, x_recognize) %识别