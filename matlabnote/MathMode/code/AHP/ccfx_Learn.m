%% 注意：应该先对判断矩阵进行一致性检验，然后再计算权重，因为只有判断矩阵通过了一致性检验，其权重才是有意义的。
%% 在下面的代码中，我们先计算了权重，然后再进行了一致性检验，这是为了顺应计算过程，事实上在逻辑上是说不过去的。
%% 因此大家自己写论文中如果用到了层次分析法，一定要先对判断矩阵进行一致性检验。
%% 而且要说明的是，只有非一致矩阵的判断矩阵才需要进行一致性检验。
%% 如果你的判断矩阵本身就是一个一致矩阵，那么就没有必要进行一致性检验。


%% 输入判断矩阵
clear;clc
disp('请输入判断矩阵A： ')
% A = input('判断矩阵A=')
A =[1 1 4 1/3 3;
 1 1 4 1/3 3;
 1/4 1/4 1 1/3 1/2;
 3 3 3 1 3;
 1/3 1/3 2 1/3 1]
% matlab矩阵有两种写法，可以直接写到一行:
% [1 1 4 1/3 3;1 1 4 1/3 3;1/4 1/4 1 1/3 1/2;3 3 3 1 3;1/3 1/3 2 1/3 1]
% 也可以写成多行:
[1 1 4 1/3 3;
 1 1 4 1/3 3;
 1/4 1/4 1 1/3 1/2;
 3 3 3 1 3;
 1/3 1/3 2 1/3 1]
% 两行之间以分号结尾（最后一行的分号可加可不加），同行元素之间以空格（或者逗号）分开。

%% 方法1：算术平均法求权重
% 第一步：将判断矩阵按照列归一化（每一个元素除以其所在列的和）
Sum_A = sum(A)

[n,n] = size(A)  % 也可以写成n = size(A,1)
% 因为我们的判断矩阵A是一个方阵，所以这里的r和c相同，我们可以就用同一个字母n表示
SUM_A = repmat(Sum_A,n,1)   %repeat matrix的缩写
% 另外一种替代的方法如下：
    SUM_A = [];
    for i = 1:n   %循环哦，这一行后面不能加冒号（和Python不同），这里表示循环n次
        SUM_A = [SUM_A; Sum_A]
    end
clc;A
SUM_A
Stand_A = A ./ SUM_A
% 这里我们直接将两个矩阵对应的元素相除即可

% 第二步：将归一化的各列相加(按行求和)
sum(Stand_A,2)

% 第三步：将相加后得到的向量中每个元素除以n即可得到权重向量
disp('算术平均法求权重的结果为：');
disp(sum(Stand_A,2) / n)
% 首先对标准化后的矩阵按照行求和，得到一个列向量
% 然后再将这个列向量的每个元素同时除以n即可（注意这里也可以用./哦）

%% 方法2：几何平均法求权重
% 第一步：将A的元素按照行相乘得到一个新的列向量
clc;A 
Prduct_A =prod(A,2)
% prod函数和sum函数类似，一个用于乘，一个用于加  dim = 2 维度是行

% 第二步：将新的向量的每个分量开n次方
Prduct_n_A = Prduct_A .^ (1/n)
% 这里对每个元素进行乘方操作，因此要加.号哦。  ^符号表示乘方哦  这里是开n次方，所以我们等价求1/n次方

% 第三步：对该列向量进行归一化即可得到权重向量
% 将这个列向量中的每一个元素除以这一个向量的和即可
disp('几何平均法求权重的结果为：');
disp(Prduct_n_A ./ sum(Prduct_n_A))

%% 方法3：特征值法求权重
% 第一步：求出矩阵A的最大特征值以及其对应的特征向量
clc
[V,D] = eig(A)    %V是特征向量, D是由特征值构成的对角矩阵（除了对角线元素外，其余位置元素全为0）
Max_eig = max(max(D)) %也可以写成max(D(:))哦~
% 那么怎么找到最大特征值所在的位置了？ 需要用到find函数，它可以用来返回向量或者矩阵中不为0的元素的位置索引。
% 那么问题来了，我们要得到最大特征值的位置，就需要将包含所有特征值的这个对角矩阵D中，不等于最大特征值的位置全变为0
% 这时候可以用到矩阵与常数的大小判断运算
D == Max_eig
[r,c] = find(D == Max_eig , 1)
% 找到D中第一个与最大特征值相等的元素的位置，记录它的行和列。

% 第二步：对求出的特征向量进行归一化即可得到我们的权重
V(:,c)
disp('特征值法求权重的结果为：');
disp( V(:,c) ./ sum(V(:,c)) )
% 我们先根据上面找到的最大特征值的列数c找到对应的特征向量，然后再进行标准化。

%% 计算一致性比例CR
clc
CI = (Max_eig - n) / (n-1);
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];  %注意哦，这里的RI最多支持 n = 15
CR=CI/RI(n);
disp('一致性指标CI=');disp(CI);
disp('一致性比例CR=');disp(CR);
if CR<0.10
    disp('因为CR < 0.10，所以该判断矩阵A的一致性可以接受!');
else
    disp('注意：CR >= 0.10，因此该判断矩阵A需要进行修改!');
end





