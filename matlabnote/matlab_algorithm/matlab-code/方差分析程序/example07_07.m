%--------------------------------------------------------------------------
%               调用friedman函数作双因素非参数方差分析
%--------------------------------------------------------------------------

% 定义样本观测值矩阵x
x = [85	82	82	79
    87	75	86	82
    90	81	80	76
    80	75	81	75];
% 调用friedman函数作Friedman检验，返回检验的p值、方差分析表table和结构体变量stats
[p,table,stats] = friedman(x)

% 调用multcompare函数对四个地区制作的京城水煮鱼这道菜的品质进行多重比较
[c,m] = multcompare(stats);
c  % 查看多重比较的结果矩阵c

[{'A';'B';'C';'D'},num2cell(m)]  % 把m矩阵转为元胞数组，与组名放在一起显示