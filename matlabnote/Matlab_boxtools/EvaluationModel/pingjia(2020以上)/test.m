clc;clear ;close all
data_table1=readtable('银行数据.xlsx');
data_get=table2array(data_table1(:,3:end));
%%
%最后求到的数据在数组B中然后都进行指标的正向化
%1,2 正向指标
%3,4,5 负向指标
%6 单点最优
%7 区间最优指标
zhibiao_label=[1,1,3,3,1,7];  %给出指标所需要处理标签
data_last=jisuan(data_get,zhibiao_label);  %全部正向化之后的数据
%A的排序结果
A_data=data_last;
%% 不同的方法
%  带有权重的TOPSIS法
W=1/length(zhibiao_label)*ones(1,length(zhibiao_label));  %可以根据层次分析法求
scoreA=TOPSIS(A_data,W);  