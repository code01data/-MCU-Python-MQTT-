clc %https://zhuanlan.zhihu.com/p/312069817
clear all
close all
a = randi([0 1000], 110, 1);
a(101:105,1) = randi([1000 2000],5,1);
a(106:110,1) = randi([-1000 0],5,1);
x = int16(rand(110,1));
x = categorical(x);
boxchart(x,a);
hold on
plot(x,a,'x');
