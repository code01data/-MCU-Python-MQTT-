%--------------------------------------------------------------------------
%  ��2.2�� ���� ����
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%   �����Ĵ���
%--------------------------------------------------------------------------
%  ������ Row vector
row = [9,8,7,6,5]
%  ������ Column vector
column = [9;8;7;6;5]  % ";"��ʾ1�н���
%{
row =
     9     8     7     6     5
column =
     9
     8
     7
     6
     5
%}
% ʹ�á�:�� ����(��)��������
% a1=J:K   ����(��)�������� a1=[J,J+1,J+2,....K]
% a2=J:D:K ����(��)�������� a2=[J,J+D,J+2*D,....J+m*D]  m=fix((K-J)/D) J,K��ʾ��Χ D��ʾ����С
a1=2:10 
a2=0:2:20
%{
a1 =

     2     3     4     5     6     7     8     9    10
a2 =

     0     2     4     6     8    10    12    14    16    18    20
%} 
%--------------------------------------------------------------------------
%   �Ȳ�����
% x1 = linspace(x1, x2)     ��(x1,x2)֮������100�����Էֲ������� ���ɵȲ�����
% x1 = linspace(x1, x2,n)   ��(x1,x2)֮������n�����Էֲ�������   ���ɵȲ�����
x1 = linspace(1, 100) 
x2 = linspace(1, 100,5) 
x3 = linspace(1, 20,5)  % 1.0000    5.7500   10.5000   15.2500   20.0000
%--------------------------------------------------------------------------
%{
x1 =
  �� 1 �� 27
     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19    20    21    22    23    24    25    26    27
  �� 28 �� 54
    28    29    30    31    32    33    34    35    36    37    38    39    40    41    42    43    44    45    46    47    48    49    50    51    52    53    54
  �� 55 �� 81
    55    56    57    58    59    60    61    62    63    64    65    66    67    68    69    70    71    72    73    74    75    76    77    78    79    80    81
  �� 82 �� 100
    82    83    84    85    86    87    88    89    90    91    92    93    94    95    96    97    98    99   100
x2 =
    1.0000   25.7500   50.5000   75.2500  100.0000
%}
%--------------------------------------------------------------------------
%   �ȱ����� logspace()
%   logx1 = logspace(a, b)    ��(a,b)֮������50�����Էֲ������� ���ɵȱ�����  x(1)=10^a x(50)=10^b
%   logx2 = logspace(a, b,n)  ��(a,b)֮������n�����Էֲ������� ���ɵȱ�����   x(1)=10^a x(n)=10^b
%--------------------------------------------------------------------------
logx1 = logspace(2, 64)       %   1.0e+257 *
logx2 = logspace(2, 1024,5)   %   0.0000    3.1623       Inf       Inf       Inf
%--------------------------------------------------------------------------
%   �����Ĳ��
%--------------------------------------------------------------------------

% ʹ�á�[]�� ��ȡ��������
A1=[1,2,3,5,6,8];
B1=A1([1 3 5])   % [1 3 5]��ʾ��ȡ��1��3��5��Ԫ��

% ʹ�á� ��ȡ������ ��ȡ��������������
% ��ȡ���� a=[1 3 5] [1 3 5]��ʾ��ȡ��1��3��5��Ԫ��
a=[1 3 5];
A2=[4,2,3,6,9,8];
B2=A2(a)
% ʹ�á�:�� ��ȡ��������
A3=[1,2,3,5,6,8];
B3=A3(1:2:6)  

%(1:2:6)  ��ʾ��1~6��Χ�ڣ�ÿ��2����ȡ��
%(m:d:n)  ��ʾ��m~n��Χ�ڣ�ÿ��d����ȡ��(d����,����С)


%--------------------------------------------------------------------------
%   ����Ĵ���
%   ���� Ԫ�ر�����[]��,����ͬ��Ԫ��֮��ʹ�ÿո���ߡ�,���ָ�  ����ͬ��֮��ʹ�á�;���ָ� 
%   ����Ԫ�ؿ�������ֵ������������ʽ�����ߺ���������Ĵ�С�ߴ粻��Ԥ������
%--------------------------------------------------------------------------
%1.ֱ�����봴������
arr1 = [22,4,5;55,77,99]
%{
arr1 =
    22     4     5  
    55    77    99
%}

%2.����MATLAB������������
% ones()  ����ȫΪ1�ľ���
% zeros() ����ȫΪ0�ľ���
% eye()   ������λ��

A4 = ones(3)    %ones(n)  ����nxnάȫ1����
A5 = ones(3,4)  %ones(m,n)  ����mxnάȫ1����

Z4 = zeros(3)    %zeros(n)  ����nxnάȫ0����
Z5 = zeros(3,4)  %zeros(m,n)  ����mxnάȫ0����

E4 = eye(3)    %eye(n)  ����nxnά��λ��
E5 = eye(2,4)  %eye(m,n)  ����mxnά��λ��

% rand()  ������(0,1)����ľ��ȷֲ��������

R4 = rand(4)     % rand(m)   ����nxnά��(0,1)����ľ��ȷֲ������ 
R5 = rand(4,5)   % rand(m,n) ����mxnά��(0,1)����ľ��ȷֲ������ 
% Rx = rand(1,2,3,4)   % rand(m,n,j,k...) ����mxnxjxk....ά��(0,1)����ľ��ȷֲ������ 
Ra = rand(size(A1))  % rand(size(A)) ����һ����A����ͬά����С����(0,1)����ľ��ȷֲ������ 
% ����һ��mxnά��(-t,t) ����ľ��ȷֲ������ Y = t- 10*rand(m,n)
% ����һ��mxnά��(-t,t) ����ľ��ȷֲ���������� Y = t- round(10*rand(m,n))
% ����һ��mxnά��(-t,t) ����ľ��ȷֲ������,����Ԫ�ؾ�ȷ��10^(-2) Y = t- round(10*rand(m,n))/100
% ����һ��mxnά��(-t,t) ����ľ��ȷֲ������,����Ԫ�ؾ�ȷ��10^(-x) Y = t- round(10*rand(m,n))/(10^x)


% randn() ������ֵΪ0,����Ϊ1�ı�׼��̬�ֲ������
Y4 = randn(4)
Y5 = randn(2,3)
Ya = randn(size(A1))

% randn(n) ������ֵΪ0,����Ϊ1�ı�׼��̬�ֲ� nxnά �����
% randn(m,n) ������ֵΪ0,����Ϊ1�ı�׼��̬�ֲ� mxnά �����
% randn(m,n,j,k) ������ֵΪ0,����Ϊ1�ı�׼��̬�ֲ� nxnxjxkά �����
% randn(size(A)) ������ֵΪ0,����Ϊ1�ı�׼��̬�ֲ� һ����A����ͬά����С �����

%save�������� load��������
%{
---��save
���ڱ��浽: e:\Note\matlabnote\matlab.mat
---��load
���ڴ� E:\Note\matlabnote\matlab.mat �м���
---��Ya
Ya =

    1.5442    0.0859   -1.4916   -0.7423   -1.0616    2.3505
---��clear
---��Ya
��������� 'Ya' �޷�ʶ��
---��load
���ڴ� E:\Note\matlabnote\matlab.mat �м���
---��Ya
Ya =
    1.5442    0.0859   -1.4916   -0.7423   -1.0616    2.3505
%}

%--------------------------------------------------------------------------
%   ����Ĳ��
%--------------------------------------------------------------------------
% ʹ�á�:�� ��ȡ��������  % (m,:) ȡ��m��Ԫ��  (:,n) ȡ��n��Ԫ��  

A6 = [1,2,3;11,4,6;7,8,9];
% ��ȡ��������  ��ȡ A6�����е�1,2��Ԫ�� A6�����е�1,2��Ԫ��
B6_1 = A6((1:2),(1:2))
% ��ȡ��������  ��ȡ A6�����е�2,3��Ԫ��
B6_2 = A6(2:3,:)
% ��ȡ��������  ��ȡ A6�����е�2,3��Ԫ��
B6_3 = A6(:,2:3)

% ʹ�á���ȡ������ ��ȡ��������
% [a b c d ...  x y z] if ��ȡA([a b c]) ��ʾȡ��a,b,c��Ԫ��  ��ȡA([x y z]) ��Ϊ�µľ��������
B6_4 = [A6([1 4]);A6([2 3])]

% ��ȡ����Ԫ��
% A6(2,3) %��2�У���3��Ԫ��
% A6([2 3])

%--------------------------------------------------------------------------
%   ����Ԫ�ص���ȡ���滻
%--------------------------------------------------------------------------

% ����Ԫ�ص���ȡ���滻
Aa1 = [1,2,3,0,0;11,4,6,0,0;7,8,9,1,1;0,0,1,1,0;1,0,0,1,0];
Ab1 = Aa1(3,3) %��ȡ��3�У���3��Ԫ��  ------>> 9

% ĳ��Ԫ�ص���ȡ
Ab2 = Aa1(3,:) %��ȡ��3��  % (m,:) ȡ��m��Ԫ�� ------>>    7,8,9,1,1
% ĳ��Ԫ�ص���ȡ
Ab3 = Aa1(:,3) %��ȡ��3�� % (:,n) ȡ��n��Ԫ��   ------>> 3 4 9 1 0
% ����Ԫ�ص���ȡ
Ab4 = Aa1([1 3],:) %��ȡ��1,3�� % ([m1 m2 m3 ],:) ȡ��m1 m2 m3��Ԫ��  1,2,3,0,0 7,8,9,1,1
% ����Ԫ�ص���ȡ
Ab5 = Aa1(:,[1 3]) %��ȡ��1,3�� % (:,[n1 n2 n3]) ȡ��n1 n2 n3��Ԫ�� 1 11 7 0 1   3 4 9 1 0
Ab6 = Aa1(:,[1 3 5]) %��ȡ��1,3 5�� % (:,[n1 n2 n3]) ȡ��n1 n2 n3��Ԫ��   1 11 7 0 1   3 4 9 1 0   0 0 1 0 0
Ab7 = Aa1([1 3 5],:) %��ȡ��1,3 5�� % (:,[n1 n2 n3]) ȡ��m1 m2 m3��Ԫ�� 1,2,3,0,0  7,8,9,1,1  1,0,0,1,0

% ��ȡm��n�� ����Ԫ�� 
Ab8 = Aa1([1 3 5],[1 5]) 
 % ([m1 m2 m3 ],[n1 n2 n3])����ȡ ��m1 m2 m3��Ԫ�� ,֮���ڴ˻���������ȡ ��n1 n2 n3��Ԫ��

% ����Ԫ�ص��滻
Aa2 = [1,2,3,0,0;11,4,6,0,0;7,8,9,1,1;0,0,1,1,0;1,0,0,1,0]
Aa2(4,5) = 100

%{
     1     2     3     0     0
    11     4     6     0     0
     7     8     9     1     1
     0     0     1     1     0
     1     0     0     1     0

     1     2     3     0     0
    11     4     6     0     0
     7     8     9     1     1
     0     0     1     1   100
     1     0     0     1     0
%}


% ����Ԫ�ص����ź͸���
% ����Ԫ�ص����� reshape()
Aa3 = [1,2,3,0,0;11,4,6,0,0;7,8,9,1,1]
Bb3 = reshape(Aa3,3,5)  % B = reshape(Aa3,m,n) ����һ��m��n�� ���ɵ������������֮ǰ��Ԫ�ظ�����ͬ ���ұ�����֮ǰ��Ԫ��
Bb4 = reshape(Aa3,5,3)  % B = reshape(Aa3,n,m) ����һ��n��m�� ���ɵ������������֮ǰ��Ԫ�ظ�����ͬ ���ұ�����֮ǰ��Ԫ��
Bb5 = reshape(Aa3,5,3,1)  % B =  reshape(Aa3,n,m,p) ���ɶ�ά���飬 ���ɵ������������֮ǰ��Ԫ�ظ�����ͬ ���ұ�����֮ǰ��Ԫ��
% ����Ԫ�صĸ��� repmat()
Aa4 = [1,2,3,0,0;11,4,6,0,0];
Bb6 = repmat(Aa3,3)    % B = repmat(Aa3,m,n) ����һ��n��n�еľ���ÿһ�鶼��Aa3
Bb7 = repmat(Aa3,2,3)  % B = repmat(Aa3,n,m) ����һ��n��m�� ÿһ�鶼��Aa3
Bb8 = repmat(Aa3,2,3,1)  % B =  repmat(Aa3,n,m,p) ���ɶ�ά���飬 ���ɵ����� ÿһ�鶼��Aa3

%{
  Aa3 =
     1     2     3     0     0
    11     4     6     0     0
     7     8     9     1     1
Bb3 =
     1     2     3     0     0
    11     4     6     0     0
     7     8     9     1     1
Bb4 =
     1     8     0
    11     3     1
     7     6     0
     2     9     0
     4     0     1
Bb5 =
     1     8     0
    11     3     1
     7     6     0
     2     9     0
     4     0     
Bb6 =

     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
Bb7 =

     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
Bb8 =

     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
     1     2     3     0     0     1     2     3     0     0     1     2     3     0     0
    11     4     6     0     0    11     4     6     0     0    11     4     6     0     0
     7     8     9     1     1     7     8     9     1     1     7     8     9     1     1
%}


%���������
%���Ӳ�������[]
Aa_1 = [12,22;33,44];
bb9 = [Aa_1,Aa_1+3;3*Aa_1,Aa_1]  %2x2
bb10 = [Aa_1,Aa_1+3;3*Aa_1,Aa_1;Aa_1-1,Aa_1-2]  %3x2
%{
  bb9 =
    12    22   |   15    25
    33    44   |   36    47
---------------------------------
    36    66   |   12    22
    99   132   |   33    44

 bb10 =
    12    22   |   15    25
    33    44   |   36    47
---------------------------------
    36    66   |   12    22
    99   132   |   33    44
---------------------------------
    11    21   |   10    20
    32    43   |   31    42
%}