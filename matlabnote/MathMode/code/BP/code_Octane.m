
%% 清空环境变量
clc
clear
%%
load data_Octane.mat
% 尽量使用新版的Matlab
% 在Matlab的菜单栏点击APP，再点击Neural Fitting app.

% 利用训练出来的神经网络模型对数据进行预测
% 例如我们要预测编号为51的样本，其对应的401个吸光度为：new_X(1,:)
% sim(net, new_X(1,:))
% 错误使用 network/sim (line 266)
% Input data sizes do not match net.inputs{1}.size.
% net.inputs{1}.size
X_train = X';   %数据需要转置
Y_train = Y';   %数据需要转置
net=newff(X_train,Y_train,10,{'logsig','purelin'}); %创建网络
net.trainParam.epochs=100;                          %迭代次数
net.trainParam.lr=0.1;                              %学习率
net.trainParam.goal=0.00004;                        %目标
[net,~]=train(net,X_train,Y_train);                 %BP神经网络训练

%% 网络预测

% 这里要注意，我们要将指标变为列向量，然后再用sim函数预测
% sim(net, new_X(1,:)')
%%
% 写一个循环，预测接下来的十个样本的辛烷值
predict_y = zeros(10,1); % 初始化predict_y
for i = 1: 10
    result = sim(net, new_X(i,:)');
    predict_y(i) = result;
end
disp('预测值为：')
disp(predict_y)



