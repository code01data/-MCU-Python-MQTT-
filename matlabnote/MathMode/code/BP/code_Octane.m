
%% ��ջ�������
clc
clear
%%
load data_Octane.mat
% ����ʹ���°��Matlab
% ��Matlab�Ĳ˵������APP���ٵ��Neural Fitting app.

% ����ѵ��������������ģ�Ͷ����ݽ���Ԥ��
% ��������ҪԤ����Ϊ51�����������Ӧ��401�������Ϊ��new_X(1,:)
% sim(net, new_X(1,:))
% ����ʹ�� network/sim (line 266)
% Input data sizes do not match net.inputs{1}.size.
% net.inputs{1}.size
X_train = X';   %������Ҫת��
Y_train = Y';   %������Ҫת��
net=newff(X_train,Y_train,10,{'logsig','purelin'}); %��������
net.trainParam.epochs=100;                          %��������
net.trainParam.lr=0.1;                              %ѧϰ��
net.trainParam.goal=0.00004;                        %Ŀ��
[net,~]=train(net,X_train,Y_train);                 %BP������ѵ��

%% ����Ԥ��

% ����Ҫע�⣬����Ҫ��ָ���Ϊ��������Ȼ������sim����Ԥ��
% sim(net, new_X(1,:)')
%%
% дһ��ѭ����Ԥ���������ʮ������������ֵ
predict_y = zeros(10,1); % ��ʼ��predict_y
for i = 1: 10
    result = sim(net, new_X(i,:)');
    predict_y(i) = result;
end
disp('Ԥ��ֵΪ��')
disp(predict_y)



