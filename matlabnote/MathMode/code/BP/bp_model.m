%% BP神经网络案例 https://mp.weixin.qq.com/s/EbHgAZ-eU1qTvRnBZ1TSWA
%% 数据的加载
clc;clear;close all;
load('abalone_data.mat')
%% 设置训练数据和测试数据
[m,n]=size(data); %m =4177 n =9  m是样本的总个数，n是指标或者变量因素加上输出的结果
train_num=round(0.8*m); %自变量 训练的数量 一般按照80%训练样本，20%测试样本
x_train_data=data(1:train_num,1:n-1);       %输入训练样本 
y_train_data=data(1:train_num,n);           %输出训练样本
x_test_data=data(train_num+1:end,1:n-1);    %输入测试样本 
y_test_data=data(train_num+1:end,n);        %输入测试样本 

x_train_data=x_train_data';
y_train_data=y_train_data';
x_test_data=x_test_data';
%x_train_regular,y_train_regular  训练数据进行归一化
[x_train_regular,x_train_maxmin] = mapminmax(x_train_data);
[y_train_regular,y_train_maxmin] = mapminmax(y_train_data);
%% 创建网络
%{
net = newff(P,T,S,TF,BTF,BLF,PF,IPF,OPF,DDF)

% net=newff(x_train_regular,y_train_regular,6,{'logsig','purelin'});
P：输入数据矩阵。
T：输出数据矩阵。
S：隐含层节点数。
TF：节点传递函数.
        包括硬限幅传递函数hardlim、对称硬限幅传递函数hardlims、线性传递函数purelin
        正切S型传递函数tansig、对数S型传递函数logsig。
BTF：训练函数.
        包括梯度下降BP算法训练函数traingd、动量反传的梯度下降BP算法训练函数traingdm
        动态自适应学习率的梯度下降BP算法训练函数traingda
        动量反传和动态自适应学习率的梯度下降BP算法训练函数traingdx、Levenberg_Marquardt的BP算法训练函数trainlm。
BLF：网络学习函数，包括BP学习规则learngd、带动量项的BP学习规则learngdm。
PF：性能分析函数，包括均值绝对误差性能分析函数mae、均方差性能分析函数mse。
IPF：输入处理函数。
OPF：输出处理函数。
DDF：验证数据划分函数。
注意：一般在使用过程中设置前面6个参数，后面4个参数采用系统默认参数。

%}
%%调用形式
%net=newff(x_train_regular,y_train_regular,6,{'logsig','logsig','logsig'});
% net=newff(x_train_regular,y_train_regular,6,{'logsig','logsig'});
net=newff(x_train_regular,y_train_regular,6,{'logsig','purelin'});
% net=newff(x_train_regular,y_train_regular,6,{'logsig','tansig'});
%% 训练网络
%{
train：BP神经网络训练函数
函数功能：用训练数据训练BP神经网络。
函数形式：[net,tr]=train(NET,X,T,Pi,Ai);
NET：待训练网络。
X：输入数据矩阵。
T：输出数据矩阵。
Pi：初始化输入层条件。
Ai：初始化输出层条件。
net:训练好的网络。
tr:训练过程记录。
%}
%训练网络
[net,~]=train(net,x_train_regular,y_train_regular);
%将输入数据归一化  （测试数据）
x_test_regular = mapminmax('apply',x_test_data,x_train_maxmin);
%% BP神经网络预测函数
%{
sim：BP神经网络预测函数
函数功能：用训练好的BP神经网络预测函数输出
函数形式：y=sim(net,x)
net:训练好的网络。
x：输入数据。  需要预测的数据
y：网络预测数据。
%}

%放入到网络输出数据
y_test_regular=sim(net,x_test_regular);
%将得到的数据反归一化得到预测数据
BP_predict=mapminmax('reverse',y_test_regular,y_train_maxmin);
% RBF_predict(find(RBF_predict<0))=-0.244;

%% 预测与误差输出
BP_predict=BP_predict';
errors_nn=sum(abs(BP_predict-y_test_data)./(y_test_data))/length(y_test_data);
figure(1)
color=[111,168,86;128,199,252;112,138,248;184,84,246]/255;
plot(y_test_data,'Color',color(2,:),'LineWidth',1)
hold on
plot(BP_predict,'*','Color',color(1,:))
hold on
titlestr=['BP神经网络','   误差为：',num2str(errors_nn)];
title(titlestr)
%%

%% 
% %设置训练次数
% net.trainParam.epochs = 50000;
% %设置收敛误差
% net.trainParam.goal=0.000001;
% newff(P,T,S,TF,BTF,BLF,PF,IPF,OPF,DDF) takes optional inputs,
%      TF- Transfer function of ith layer. Default is 'tansig' for
%              hidden layers, and 'purelin' for output layer.
%%激活函数的设置
%     compet - Competitive transfer function.
%     elliotsig - Elliot sigmoid transfer function.
%     hardlim - Positive hard limit transfer function.
%     hardlims - Symmetric hard limit transfer function.
%     logsig - Logarithmic sigmoid transfer function.
%     netinv - Inverse transfer function.
%     poslin - Positive linear transfer function.
%     purelin - Linear transfer function.
%     radbas - Radial basis transfer function.
%     radbasn - Radial basis normalized transfer function.
%     satlin - Positive saturating linear transfer function.
%     satlins - Symmetric saturating linear transfer function.
%     softmax - Soft max transfer function.
%     tansig - Symmetric sigmoid transfer function.
%     tribas - Triangular basis transfer function.
%%
%        BTF - Backprop network training function, default = 'purelin'.
%        BLF - Backprop weight/bias learning function, default = 'learngdm'.
%        PF  - Performance function, default = 'mse'.
%        IPF - Row cell array of input processing functions.
%              Default is {'fixunknowns','remconstantrows','mapminmax'}.
%        OPF - Row cell array of output processing functions.
%              Default is {'remconstantrows','mapminmax'}.
%        DDF - Data division function, default = 'dividerand';
%      and returns an N layer feed-forward backprop network.
%  
%      The transfer functions TF{i} can be any differentiable transfer
%      function such as TANSIG, LOGSIG, or PURELIN.
%  
%      The training function BTF can be any of the backprop training
%      functions such as TRAINLM, TRAINBFG, TRAINRP, TRAINGD, etc.
%%