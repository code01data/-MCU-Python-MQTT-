%最大值max
% M = min(A,B) 返回一个和A和B同大小的数组，
% 其中的元素是从A或B中取出的最大元素(两个矩阵，必须维数相同，相同位置的元素比较大小)
% 当A是一个列向量时候，返回一个最大值
% 当Amxn是一个矩阵的时候，有以下几种情况：
% C = max(max(A))，返回矩阵最大值
% D = max(A,[],1)，返回每一列的最大值，即mx1的行向量 
% E = max(A,[],2)，返回每一行的最大值，即1xm的列向量
% F = max(A,8)，当元素小于8，用8填充
% [U V] = max(A)，返回行列最大元素的行号与列号 U为列极值(每列中的最值)，V为行号(第几行)
% U=max(A,n):n是一个标量,结果U是与A同型的向量或矩阵,U的每个元素等于A对应元素和n中的较大者。
A = [1 4 13 9;
    2 39 11 6;
    -1 2 8 17;
    21 5 11 0];
max_d1 = max(A,[],1) %返回每一列的最大值
max_d2 = max(A,[],2) %返回每一行的最大值
[U,V] = max(A)   %返回行列最大元素的行号与列号
max_H = max(A) %返回每一列的最大值，即mx1的行向量
max_J = max(A(:,:)) %返回每一列的最大值，即mx1的行向量
max_I = max(A(:)) %返回矩阵所有元素里面的最大值
max_C = max(max(A)) %返回矩阵所有元素里面的最大值


%最小值min
% 当A是一个列向量时候，返回一个最小值
% 当Amxn是一个矩阵的时候，有以下几种情况：
% C = min(min(A))，返回矩阵最小值
% D = min(A,[],1)，返回每一列的最小值，即mx1的行向量 
% E = min(A,[],2)，返回每一行的最小值，即1xm的列向量
% F = min(A,8)，当元素小于8，用8填充
% [U V] = min(A)，返回行列最大元素的行号与列号 U为列极值(每列中的最值)，V为行号(第几行)
% M = min(A,B) 返回一个和A和B同大小的数组，
% 其中的元素是从A或B中取出的最小元素(两个矩阵，必须维数相同，相同位置的元素比较大小)
% U=min(A,n):n是一个标量,结果U是与A同型的向量或矩阵,U的每个元素等于A对应元素和n中的较小者。
min_d1 = min(A,[],1) %返回每一列的最小值
min_d2 = min(A,[],2) %返回每一行的最小值
[U,V] = min(A)   %返回行列最小元素的行号与列号
min_H = min(A) %返回每一列的最小值，即mx1的行向量
min_J = min(A(:,:)) %返回每一列的最小值，即mx1的行向量
min_I = min(A(:)) %返回矩阵所有元素里面的最小值
min_C = min(min(A)) %返回矩阵所有元素里面的最小值

%求和sum()
% sum_X是一个向量 sum_A是一个矩阵
% sum(sum_X) 返回向量的元素之和
% sum(sum_A) 返回一个行向量，其中第i个元素是第i列的元素和 (返回每列的元素和)
% sum(sum_A,1))返回一个行向量，其中第i个元素是第i列的元素和 (返回每列的元素和)
% sum(sum_A,2) 返回一个列向量，其中第i个元素是第i行的元素和 (返回每行的元素和)
sum_X = [1,2,3,4,5];
sum_A =[1 4 13 9;
        2 39 11 6;
        -1 2 8 17;
        21 5 11 0];
sum_B = sum(sum_X)
sum_C = sum(sum_A)   %1列和
sum_D = sum(sum_A,2) %2行和

%求积prod()
% prod_X是一个向量 prod_A是一个矩阵
% prod(prodm_X) 返回向量的元素之积
% prod(prod_A) 返回一个行向量，其中第i个元素是第i列的元素积 (返回每列的元素积)
% prod(prod_A,1))返回一个行向量，其中第i个元素是第i列的元素积 (返回每列的元素积)
% prod(prod_A,2) 返回一个列向量，其中第i个元素是第i行的元素积 (返回每行的元素积)
prod_X = [1,2,3,4,5];
prod_A =[1 4 13 9;
        2 39 11 6;
        -1 2 8 17;
        21 5 11 0];
prod_B = prod(prod_X)  %返回向量的元素之积
prod_C = prod(prod_A)   %1列积
prod_D = prod(prod_A,2) %2行积

%求平均值,中值
% mean_X是一个向量 mean_A是一个矩阵
% mean(mean_X) 返回向量的算术平均值
% mean(mean_A) 返回一个行向量，其中第i个元素是第i列的算术平均值 (返回每列的算术平均值)
% mean(mean_A,1))返回一个行向量，其中第i个元素是第i列的算术平均值 (返回每列的算术平均值)
% mean(mean_A,2) 返回一个列向量，其中第i个元素是第i行的算术平均值 (返回每行的算术平均值)
mean_X = [1,2,3,4,5];
mean_A =[1 4 13 9;
        2 39 11 6;
        -1 2 8 17;
        21 5 11 0];
mean_B = mean(mean_X)  %返回向量的算术平均值
mean_C = mean(mean_A)   %1 每列的算术平均值
mean_D = mean(mean_A,2) %2 每行的算术平均值
%中位数: 按顺序排列的一组数据中居于中间位置的数，代表一个样本、种群或概率分布中的一个数值，其可将数值集合划分为相等的上下两部分。
%       对于有限的数集，可以通过把所有观察值高低排序后找出正中间的一个作为中位数。
median_B = median(mean_X)  %返回向量的中位数
median_C = median(mean_A)   %1 每列的中位数
median_D = median(mean_A,2) %2 每行的中位数  


%累加和
% cumsum(mean_X) 返回向量的累加和向量
% cumsum(mean_A) 返回一个矩阵，其中第i个元素是第i列的累加和向量 (返回每列的累加和向量)
% cumsum(mean_A,1))返回一个矩阵，其中第i列是第i列的累加和向量 (返回每列的累加和向量)
% cumsum(mean_A,2) 返回一个矩阵，其中第i行是第i行的累加和向量 (返回每行的累加和向量)
%累加积
% cumprod(mean_X) 返回向量的累加积向量
% cumprod(mean_A) 返回一个矩阵，其中第i个元素是第i列的累加积向量 (返回每列的累加积向量)
% cumprod(mean_A,1))返回一个矩阵，其中第i列是第i列的累加积向量 (返回每列的累加积向量)
% cumprod(mean_A,2) 返回一个矩阵，其中第i行是第i行的累加积向量 (返回每行的累加积向量)
cumsum_B = cumsum(mean_X) 
cumsum_C = cumsum(mean_A)   
cumsum_D = cumsum(mean_A,2)  
cumprod_B = cumprod(mean_X)  
cumprod_C = cumprod(mean_A)  
cumprod_D = cumprod(mean_A,2) 



%标准差std std(A,falg,dim) 默认flag=0,dim=1
std_B = std(mean_X,0,1) 
std_C = std(mean_A,0,1)   
std_D = std(mean_A,0,2)  
%方差var = std^2
var_B = var(mean_X,0,1)  
var_C = var(mean_A,0,1)  
var_D = var(mean_A,0,2) 