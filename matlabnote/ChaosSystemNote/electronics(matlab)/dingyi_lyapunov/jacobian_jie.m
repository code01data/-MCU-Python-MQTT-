%系统雅可比矩阵，求解
function  Jaco=jacobian_jie(input)
%input:系统参数输入
%Jaco：输出的雅可比矩阵
global delt r b;

x=input(1);
y=input(2);
z=input(3);
Jaco=[-delt delt 0;
      -z+r  -1   -x;
      y     x    -b]';