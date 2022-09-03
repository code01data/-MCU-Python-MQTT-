%------------------------------------------------------------------------------------
%  ��3.2��  MATLAB ����ͼ�� ---��ά��������ͼ 
%------------------------------------------------------------------------------------


% plot3() ��ά�����ͼ
%{
    plot3(X,Y,Z) ������ά�ռ��е����ꡣ
        Ҫ�������߶����ӵ�һ�����꣬�뽫 X��Y��Z ָ��Ϊ��ͬ���ȵ�������
        Ҫ��ͬһ���������ϻ��ƶ������꣬�뽫 X��Y �� Z �е�����һ��ָ��Ϊ��������ָ��Ϊ������
    plot3(X,Y,Z,LineSpec) ʹ��ָ�������͡���Ǻ���ɫ������ͼ��
    plot3(X1,Y1,Z1,...,Xn,Yn,Zn) ��ͬһ���������ϻ��ƶ������ꡣʹ�ô��﷨��Ϊ����������ָ��Ϊ��������������
    plot3(X1,Y1,Z1,LineSpec1,...,Xn,Yn,Zn,LineSpecn) ��Ϊÿ�� XYZ ��Ԫ��ָ���ض������͡���Ǻ���ɫ��
    �����Զ�ĳЩ��Ԫ��ָ�� LineSpec������������Ԫ��ʡ���������磬plot3(X1,Y1,Z1,'o',X2,Y2,Z2) �Ե�һ����Ԫ��ָ����ǣ���û�жԵڶ�����Ԫ��ָ����ǡ�
    plot3(___,Name,Value) ʹ��һ����������-ֵ�������ָ�� Line ���ԡ��������������������ָ�����ԡ��й������б�������� Line ���ԡ�
%}

%  ����1������
plot3_t = [0:pi/100:20*pi];
plot3_x1 = sin(plot3_t);
plot3_y1 = cos(plot3_t);
plot3_z1 = plot3_t.*sin(plot3_t) +plot3_t.*cos(plot3_t);
figure
plot3(plot3_x1,plot3_y1,plot3_z1)
grid 
title('��ά����demo');
xlabel('X')
ylabel('Y')
zlabel('Z')

%���ƶ������
t1 = 0:pi/500:pi;
xt1 = sin(t1).*cos(10*t1);
yt1 = sin(t1).*sin(10*t1);
zt1 = cos(t1);

xt2 = sin(t1).*cos(12*t1);
yt2 = sin(t1).*sin(12*t1);
zt2 = cos(t1);
figure
plot3(xt1,yt1,zt1,xt2,yt2,zt2) %plot3(x1,y1,z1,x2,y2,z2,.....,xn,yn,zn) ����
title('���ƶ������demo');
%ʹ�þ�����ƶ������

t = 0:pi/500:pi;
X(1,:) = sin(t).*cos(10*t);
X(2,:) = sin(t).*cos(12*t);
X(3,:) = sin(t).*cos(20*t);

Y(1,:) = sin(t).*sin(10*t);
Y(2,:) = sin(t).*sin(12*t);
Y(3,:) = sin(t).*sin(20*t);

Z = cos(t);
figure
plot3(X,Y,Z)
title('���� ���ƶ������demo');


% ��ά����ͼ meshgrid()
%{
    MATLAB�ṩ��mesh������surf������������ά����ͼ��mesh�������ڻ�����ά����ͼ��
    �ڲ���Ҫ�����ر�ϸ����ά����ͼʱ������ͨ����ά����ͼ����ʾ��ά���档surf���ڻ�����ά����ͼ��������֮��Ĳ�������ɫ��䡣
    mesh������surf�����ĵ��ø�ʽ���£�
    mesh��x,y,z,c��
    mesh(X,Y,Z) ����һ������ͼ��������ͼΪ��ά���棬��ʵɫ����ɫ��������ɫ���ú��������� Z �е�ֵ����Ϊ�� X �� Y ����� x-y ƽ���е������Ϸ��ĸ߶ȡ�����ɫ�� Z ָ���ĸ߶ȶ��졣
    surf��x,y,z,c��
%}
% [X,Y] = meshgrid(x,y) �������� x �� y �а��������귵�ض�ά�������ꡣ
% X ��һ������ÿһ�е��������� x;Y Ҳ��һ������ÿһ�е��������� x;���� X �� Y ��ʾ�������� length(y) ���к� length(x) ���С�
% [X,Y] = meshgrid(x) �� [X,Y] = meshgrid(x,x) ��ͬ�������������СΪ length(x)��length(x) �ķ����������ꡣ
% [X,Y,Z] = meshgrid(x,y,z) ���������� x��y �� z �������ά�������ꡣX��Y �� Z ��ʾ������Ĵ�СΪ length(y)��length(x)��length(z)��
% [X,Y,Z] = meshgrid(x) �� [X,Y,Z] = meshgrid(x,x,x) ��ͬ�������������СΪ length(x)��length(x)��length(x) ����ά�������ꡣ

% ��ά����
x1 = 1:3;
y1 = 1:5;
[X,Y] = meshgrid(x1,y1)

%{
    X =

     1     2     3
     1     2     3
     1     2     3
     1     2     3
     1     2     3


Y =

     1     1     1
     2     2     2
     3     3     3
     4     4     4
     5     5     5

��X.^2+Y.^2

ans =

     2     5    10
     5     8    13
    10    13    18
    17    20    25
    26    29    34

��
%}

x2 = -2:0.25:2;
y2 = x2;
[X1,Y1] = meshgrid(x2);
F1 = X1.*exp(-X1.^2-Y1.^2);
% surf(x,y,x.*exp(-x.^2-(y').^2)) %����ֱ��ʹ�ã�����Ҫ��������
figure
surf(X1,Y1,F1) %surf(X,Y,Z) ����һ����ά����ͼ������һ������ʵɫ�ߺ�ʵɫ�����ά���档
% �ú��������� Z �е�ֵ����Ϊ�� X �� Y ����� x-y ƽ���е������Ϸ��ĸ߶ȡ��������ɫ���� Z ָ���ĸ߶ȶ��仯��
title('��ά����ͼdemo');


% ��ά����
x = 0:2:6;
y = 0:1:6;
z = 0:3:6;
[X,Y,Z] = meshgrid(x,y,z);
F = X.^2 + Y.^2 + Z.^2;
gridsize = size(F) % ȷ������Ĵ�С gridsize = 7     4     3


[X2,Y2] = meshgrid(-8:.5:8);
R = sqrt(X2.^2 + Y2.^2) + eps;
Z2 = sin(R)./R;
figure
mesh(X2,Y2,Z2)
title('��ά����ͼdemo');


%Ϊ����ͼָ����ɫͼ��ɫ  mesh(X,Y,Z,C)
% ͨ���������ĸ��������� C ��ָ������ͼ����ɫ������ͼʹ�� Z ȷ���߶ȣ�ʹ�� C ȷ����ɫ��ʹ����ɫͼָ����ɫ������ɫͼʹ�õ������ֱ�ʾɫ���ϵ���ɫ��
% ʹ����ɫͼʱ��C �� Z ��С��ͬ����ͼ��������ɫ������ʾ C �е�����ֵ��ζ�Ӧ����ɫͼ�е���ɫ��
[X3,Y3] = meshgrid(-8:.5:8);
R3 = sqrt(X3.^2 + Y3.^2) + eps;
Z3 = sin(R3)./R3;
C3 = X3.*Y3;
figure
mesh(X3,Y3,Z3,C3)
colorbar 
title('��ά����ͼ ָ����ɫdemo');


%��ά�ռ�ȸ���ͼ  contour3()
%{
    contour3(Z) ����һ���������� Z �ĵ�ֵ�ߵ���ά�ȸ���ͼ������ Z ���� x-y ƽ���ϵĸ߶�ֵ��MATLAB? ���Զ�ѡ��Ҫ��ʾ�ĵȸ��ߡ�
            Z ���к��������ֱ���ƽ���е� x �� y ���ꡣ
    contour3(X,Y,Z) ָ�� Z �и�ֵ�� x �� y ���ꡣ
    contour3(___,levels) ��Ҫ��ʾ�ĵȸ���ָ��Ϊ������һ�﷨�е����һ��������
            �� levels ָ��Ϊ����ֵ n������ n ���Զ�ѡ��Ĳ㼶���߶ȣ�����ʾ�ȸ��ߡ�
            Ҫ��ĳЩ�ض��߶Ȼ��Ƶȸ��ߣ��뽫 levels ָ��Ϊ��������ֵ��������Ҫ��һ���߶� (k) ���Ƶȸ��ߣ��뽫 levels ָ��Ϊ��Ԫ�������� [k k]��
    contour3(___,LineSpec) ָ���ȸ��ߵ����ͺ���ɫ��
    contour3(___,Name,Value) ʹ��һ����������-ֵ�������ָ���ȸ���ͼ������ѡ��������������������֮��ָ����Щѡ��
%}
[X4,Y4,Z4] = sphere(50); %����
figure
contour3(X4,Y4,Z4);
title('����ȸ���demo');


[X5,Y5] = meshgrid(-5:0.25:5);
Z5 = X5.^2 + Y5.^2;
figure 
contour3(X5,Y5,Z5,50) %ָ�� 50 �ȸ��߲㼶  contour3(X5,Y5,Z5,N)
title('ָ��50�ȸ��߲㼶');