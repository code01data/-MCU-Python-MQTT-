syms a; % 符号
syms d;
syms b;
syms c;

% %===============================================

D1=[0,1,0;0,0,1;pi*0.15,-0.3,-0.3]; %系数矩阵,平衡点为0


aa=sym(D1);
bb=poly(aa);  %求特征多项式表达式
cc=simple(bb)%化简特征多项式
[V,A]=eig(D1);
 d1=diag(A)

D11=[0,10,0;0,0,10;-pi*5*c,-10*a,-10*b]; %系数矩阵,平衡点为0
aa1=sym(D11);
bb1=poly(aa1);  %求特征多项式表达式
cc1=simple(bb1)%化简特征多项式
% [V,A]=eig(D1);
%  d1=diag(A)
%  aa=sym(D);
%  bb=poly(aa);
%  cc=simple(bb)
%  [V,A]=eig(D2);
%  d2=diag(A)
%===============================================