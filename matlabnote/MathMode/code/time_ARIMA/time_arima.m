clear all
clc
% ������Դ������
data=[10930,10318,10595,10972,7706,6756,9092,10551,9722,10913,11151,8186,6422,6337,11649,11652,10310,12043,7937,6476,9662,9570,9981,9331,9449,6773,6304,9355 ...
10477,10148,10395,11261,8713,7299,10424,10795,11069,11602,11427,9095,7707,10767, 12136,12812,12006,12528,10329,7818,11719,11683,12603,11495,13670,11337,10232 ...
13261,13230,15535,16837,19598,14823,11622,19391,18177,19994,14723,15694,13248,9543,12872,13101,15053,12619,13749,10228,9725,14729,12518,14564,15085,14722 ...
11999,9390,13481,14795,15845,15271,14686,11054,10395];

subplot(1,3,1)
plot(data,'b-','LineWidth',2)
xlabel('time')
ylabel('data')
set(gca,'fontsize',15)

subplot(1,3,2)
ddata = diff(data);
plot(ddata,'b-','LineWidth',2)
xlabel('time')
ylabel('data��һ�ײ��')
set(gca,'fontsize',15)

subplot(1,3,3)
dddata = diff(data,2);
plot(dddata,'b-','LineWidth',2)
xlabel('time')
ylabel('data�Ķ��ײ��')
set(gca,'fontsize',15)


% �������ֵout1=0,��ܾ�ԭ���裬˵�������ǲ�ƽ�ȵģ� ������out1=1����ʾ���ܾ�ԭ���裬����ƽ��.
out1 = adftest(data)    %out1 =0 ���ݲ�ƽ��
%����kpss�������෴���������ֵout1=0,���ܾܾ�ԭ���裬˵��������ƽ�ȵģ� ������out1=1����ʾ�ܾ�ԭ���裬���ݲ�ƽ��
out2 = kpsstest(data)   %out2 =1 ���ݲ�ƽ��


%{
>> adftest(data)
ans =0
>> kpsstest(data)
ans =1

   ���ƽ���Լ��������ԭʼʱ�����в�ƽ�ȣ��Ǿ���Ҫ��ʱ��ԭʼ����ȡ��֣��ٽ��м��顣
   �Ƚ���һ�ײ�֣����ƽ�Ⱦͽ�����ֹ��̡�������ɲ�ƽ�ȵĻ����ٴ����֣�ֱ��ͨ������
%}

% �����������ƫ�����ͼ
% ����Ҫ��һ�ײ��֮������ݻ�ͼ
figure
subplot(2,1,1)
autocorr(ddata,40)
ylabel('ACF')
set(gca,'fontsize',15)

subplot(2,1,2)
parcorr(ddata,40)
ylabel('PACF')
set(gca,'fontsize',15)

%% ����pqȡֵ
pmax = 4;
qmax = 4;
d = 1;
%[p q ]=findPQ(data,pmax,qmax,d);

%% ����ģ��
p = 3;q = 4;
Mdl = arima(p, 1, q);  %�ڶ�������ֵΪ1����һ�ײ��
EstMdl = estimate(Mdl,data');
%% ģ��Ԥ��
step = 10;
[forData,YMSE] = forecast(EstMdl,step,'Y0',data');  
 %matlab2018�����°汾дΪPredict_Y(i+1) = forecast(EstMdl,1,'Y0',Y(1:i)); 
lower = forData - 1.96*sqrt(YMSE); %95������������
upper = forData + 1.96*sqrt(YMSE); %95������������
figure
plot(1:length(data),data)
hold on
plot((length(data)+1):length(data)+step,forData)
hold on
plot((length(data)+1):length(data)+step,lower)
plot((length(data)+1):length(data)+step,upper)