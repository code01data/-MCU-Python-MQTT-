%{
 * @Descripttion : ������ϵͳ���Ӽ�������ͼ  
 * @version      : V1.0
 * @Author       : Fzx
 * @LastEditTime : 2021-11-20 16:37:12
 * @note: ��Ҫ�޸�3���ط������Ѿ��� *���� �ĸ�ʽ���
 * ͨ���۲�Poincare�����Ͻص����������ж��Ƿ������磺
 * ��Poincare����������ֻ��һ���������������ɢ��ʱ���˶������ڵģ�
 * ��Poincare��������һ�������ʱ���˶���׼���ڵ� 
 * ��Poincare��������һЩ��Ƭ�ľ��з��νṹ���ܼ���ʱ���˶����ǻ��硣
%}

clc
clear
close all;
x
y
z
w
% *����1��ϵͳ����ز���
[t, Y] = ode45(@myFun, 0:0.001:200, [10,10,10,10]);

% *����2����άͼ��3��������Դ
xSour = 3;  % ��Y�е� xSour ��������Ϊ������ά����ϵ��x������
ySour = 1;  % ��Y�е� ySour ��������Ϊ������ά����ϵ��y������
zSour = 2;  % ��Y�е� zSour ��������Ϊ������ά����ϵ��z������

% *����3����ֱ��x��Ľ���
xCut = 20;

% �Ӽ�������
tLen = length(t);  % ��������ݵĳ��� 500 / 0.01 + 1
for k = 1 : tLen-1
    if (Y(k, xSour) > xCut && Y(k+1, xSour) < xCut) || (Y(k, xSour) < xCut && Y(k+1, xSour) > xCut) 
        % �ֱ�������x y z��б�ʺͽؾ�
        xRate = (Y(k+1, xSour) - Y(k, xSour)) / (t(k+1) - t(k));                   
        xInter = (Y(k, xSour) * t(k+1) - Y(k+1, xSour) * t(k)) / (t(k+1) - t(k));    
        yRate = (Y(k+1, ySour) - Y(k, ySour)) / (t(k+1) - t(k));                    
        yInter = (Y(k, ySour) * t(k+1) - Y(k+1, ySour) * t(k)) / (t(k+1) - t(k));    
        zRate = (Y(k+1, zSour) - Y(k, zSour)) / (t(k+1) - t(k));                   
        zInter = (Y(k, zSour) * t(k+1) - Y(k+1, zSour) * t(k)) / (t(k+1) - t(k));  
        % ����y��z��xCut�����ϵ�����
        g = (xCut - xInter) / xRate;  
        yData = yRate * g + yInter;
        zData = zRate * g + zInter;  
        % ���ƽ���ͼ�ϵĽ���  	  	
        plot(yData, zData, '.');
        hold on;
    end
end

xlabel('x');
ylabel('y');