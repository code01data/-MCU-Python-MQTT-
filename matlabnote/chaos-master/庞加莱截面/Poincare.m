%{
 * @Descripttion : 整数阶系统的庞加莱截面图  
 * @version      : V1.0
 * @Author       : Fzx
 * @LastEditTime : 2021-11-20 16:37:12
 * @note: 需要修改3处地方，都已经用 *设置 的格式标出
 * 通过观察Poincare截面上截点的情况可以判断是否发生混沌：
 * 当Poincare截面上有且只有一个不动点或少数离散点时，运动是周期的；
 * 当Poincare截面上是一封闭曲线时，运动是准周期的 
 * 当Poincare截面上是一些成片的具有分形结构的密集点时，运动便是混沌。
%}

clc
clear
close all;
x
y
z
w
% *设置1：系统及相关参数
[t, Y] = ode45(@myFun, 0:0.001:200, [10,10,10,10]);

% *设置2：三维图的3个数据来源
xSour = 3;  % 以Y中第 xSour 列数据作为整个三维坐标系的x轴数据
ySour = 1;  % 以Y中第 ySour 列数据作为整个三维坐标系的y轴数据
zSour = 2;  % 以Y中第 zSour 列数据作为整个三维坐标系的z轴数据

% *设置3：垂直于x轴的截面
xCut = 20;

% 庞加莱截面
tLen = length(t);  % 求迭代数据的长度 500 / 0.01 + 1
for k = 1 : tLen-1
    if (Y(k, xSour) > xCut && Y(k+1, xSour) < xCut) || (Y(k, xSour) < xCut && Y(k+1, xSour) > xCut) 
        % 分别计算关于x y z的斜率和截距
        xRate = (Y(k+1, xSour) - Y(k, xSour)) / (t(k+1) - t(k));                   
        xInter = (Y(k, xSour) * t(k+1) - Y(k+1, xSour) * t(k)) / (t(k+1) - t(k));    
        yRate = (Y(k+1, ySour) - Y(k, ySour)) / (t(k+1) - t(k));                    
        yInter = (Y(k, ySour) * t(k+1) - Y(k+1, ySour) * t(k)) / (t(k+1) - t(k));    
        zRate = (Y(k+1, zSour) - Y(k, zSour)) / (t(k+1) - t(k));                   
        zInter = (Y(k, zSour) * t(k+1) - Y(k+1, zSour) * t(k)) / (t(k+1) - t(k));  
        % 计算y与z在xCut截面上的坐标
        g = (xCut - xInter) / xRate;  
        yData = yRate * g + yInter;
        zData = zRate * g + zInter;  
        % 绘制截面图上的交点  	  	
        plot(yData, zData, '.');
        hold on;
    end
end

xlabel('x');
ylabel('y');