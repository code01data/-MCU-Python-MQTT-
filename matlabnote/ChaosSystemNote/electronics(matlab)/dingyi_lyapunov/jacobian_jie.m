%ϵͳ�ſɱȾ������
function  Jaco=jacobian_jie(input)
%input:ϵͳ��������
%Jaco��������ſɱȾ���
global delt r b;

x=input(1);
y=input(2);
z=input(3);
Jaco=[-delt delt 0;
      -z+r  -1   -x;
      y     x    -b]';