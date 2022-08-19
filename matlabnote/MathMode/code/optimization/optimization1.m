%--------------------------------------------------------------------------
%  数学建模 优化算法
%   线性规划 Linear Programming
%   非线性规划NLP
%   整数规划
%   目标规划
%--------------------------------------------------------------------------

%  线性规划(LP) Linear Programming
%{

调用格式：其中，c和x为n维列向量；b为m维列向量；A为mXn矩阵。
[x,fval,exitflag,output,lambda]=linprog(c,A,b,Aeq,beq,LB,UB,x0,options)
    其中，
    x返回最优解；fval返回目标函数值；
    A和b对应不等式约束Ax<b；
    Aeq和beq对应等式约束Ax=b；
    LB和UB分别是变量x的下界和上界；
    x0为x的初始值；options为控制参数。

    如果没有不等式约束条件则A,b = []
    如果没有等式约束条件则Aeq,beq = []
    exitflag返回算法停止的原因：
    1表示成功找到最优解，0表示达到最大选代次数，不能继续寻找最优解，<0表示优化失败
    -2未找到可行解，-3问题没有定义边界，-4 NaN存在导致算法退出，-5原始对偶问题没有可行解，-7算法搜索方向存在问题;
%}

%线性规划案例1(题目见--优化算法-线性规划.md)

c = [2, 3, 1];
A = [1, 4, 2; 3, 2, 0];
b = [8, 6];

[x, fval] = linprog(c, -A, -b, [], [], zeros(3, 1))
%Aeq,beq = []没有等式约束条件
% -A,-b 的原因是 不等式是大于号  应该转换成标准形式小于号

c1 =- [2, 1, -1]; %求解最大值需要改成  -[]
A1 = [1, 4, -1; 2, -2, 1];
b1 = [4, 12]
A1eq = [1, 1, 2];
b1eq = [6];

[x1, fval1] = linprog(c1, A1, b1, A1eq, b1eq, zeros(3, 1))

%x返回最优解；fval返回目标函数值；

c2 = [2, 3, -5]; %求解最大值需要改成  -[] 或者输出 '-c'
A2 = [2, -5, 1]; %不等式大于号  应该转换成标准形式小于号
b2 = [10]; %不等式大于号  应该转换成标准形式小于号
A2eq = [1, 1, 1];
b2eq = [7];

[x2, fval2] = linprog(-c2, -A2, -b2, A2eq, b2eq, zeros(3, 1)) %-fval2才是最大值

% 非线性规划NLP
%如果目标函数或约束条件中包含非线性函数，就称这种规划问题为非线性规划问题。
%{
[x,fval,exitflag,output,lambda,grad,hessian]= fmincon('fun',x0,A,b,Aeq,beq,VLB,VUB,'nonlcon',options0)
其中，大部分参数同线性规划；
    VLB和UVB分别是变量x的下界和上界；
    "fun'为用M文件定义的目标函数F(x)；
“nonlcon'为用M文件定义的非线性向量函数[C(x),Ceq(x)]。
A，b，Aeq，beq定义了线性约束A.x<b，Aeq.x =beq，
如果没有线性约束，则A=[]，b=[]，Aeq =[]，beq =[]；
%}


%非线性规划案例1(题目见--优化算法-非线性规划.md)
x0 = rand(2,1);
VLB = zeros(2,1);
[x,fval,exitflag,output,lambda,grad,hessian]= fmincon('fun1',x0,[],[],[],[],VLB,[],'fun2')


x0_1= rand(3,1);
VLB1 = zeros(3,1);
[x,fval]= fmincon('fun_c1',x0_1,[],[],[],[],VLB1,[],'fun_c2')

%二次规划(线性代数 二次型)(题目见--优化算法-非线性规划.md)
%{
[x,fval,exitflag，output] = quadprog(H,f,A,b,Aeq,beq,LB,UB,x0,options)
\其中，大部分参数同线性规划；
    LB和VB分别是变量x的下界和上界；
    A和b对应不等式约束Ax<b；
    Aeq和beq对应等式约束Ax=b；
    H %实对称矩阵的2倍
    f %一次项系数
    x0为x的初始值；options为控制参数。
%}
%二次型换实对称矩阵

Hx2 = 2*[2,-2;-2,4]; %实对称矩阵
fx2 = [-6,-3];%一次项系数
Ax2 = [1,1;4,1];%不等式约束条件
bx2 = [3;9];%不等式约束条件

[x,fval,exitflag] = quadprog(Hx2,fx2,Ax2,bx2,[],[],zeros(2,1))

