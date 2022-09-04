clear
close all
clc

load('alldata.mat');

rho_threshold = 0.5;  % 给出 rho 的阈值
row_nums = size(rho_max_sorted, 1); % 行数
row_nums_array = (1:row_nums)'; % 行序号数组

% 第1列:行序号; 第2列:相关系数变量连接; 第3列:相关系数rho值;
% 第4列:相关系数p值; 第5列:相关系数变量起点x序号; 第6列:相关系数变量终点x序号值;   
rho_max_sorted = [row_nums_array rho_max_sorted];
rho_value_col_id = 3; % rho 值列序号
p_value_col_id = 4; % p 值列序号
x_id_begin_col_id = 5; % x变量id 起始所在列
x_id_end_col_id = 6; % x变量id 结束所在列

x_id_matrix = zeros(row_nums, row_nums);
rho_matrix = x_id_matrix;
p_matrix = x_id_matrix;

for i=1:row_nums
    rho_abstract = rho_max_sorted(i,rho_value_col_id); % 检索使用的 rho 值
    
    % rho 值大于阈值，则进行抽取，进行变量id合并
    if abs(rho_abstract) >= rho_threshold
        x_begin = rho_max_sorted(i, x_id_begin_col_id);
        x_end = rho_max_sorted(i, x_id_end_col_id);
        [row_begin, col_begin] = find(x_id_matrix(:,2:end)==x_begin);
        if ~isempty(row_begin) % 若起点
            
            
            [row_end, col_end] = find(x_id_matrix(:,2:end)==x_end);
            if ~isempty(row_end)
                corr_coef_matrix_abstract = rho_max_sorted();
            else
                
            end
            
            x_id_matrix(row_begin,1) = x_id_matrix(row_begin,1) + 1;
            x_id_matrix(
        end
        
    % rho 值小于阈值, 则若属于某个变量的高相关，则直接丢弃；如果不属于某个变量的高相关，则新增行
    else 
        
    end
end