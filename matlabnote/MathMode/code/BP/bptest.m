close all; clearvars; clear; %清空工作环境
P = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
T = [0, 1, 2, 3, 4, 3, 2, 1, 2, 3, 4];
%由于feedforwardnet函数自动对样本进行归一化和划分训练、验证、测试集,
%所以就不用手动将数据进行归一化处理，但不知道有没有打乱顺序
% n=size(P,2); temp=randperm(n); P_train=P(temp(1:8));
% T_train=T(temp(1:8)); P_test=P(temp(9:end)); T_test=T(temp(9:end));
%
% [p_train,p_input]=mapminmax(P_train,0,1);
% [t_train,t_output]=mapminmax(T_train,0,1);
% p_test=mapminmax(P_test,p_input);
net = feedforwardnet(5, 'traingd'); 
%是'5'是指隐含层有5个神经元，这里只有一个隐含层，多个隐含层神经元的个数设置为[5,3,...]

net.trainParam.lr = 0.01; %学习速率
net.trainParam.epochs = 10000; %最大训练次数
net.trainParam.goal = 1e-6; %最小误差，达到该精度，停止训练
net.trainParam.show = 50; %每50次展示训练结果
net = train(net, P, T); %训练
Y = net(P); %输出
perf = perform(net, Y, T);%误差
plot(P, T, P, Y, 'r-')
