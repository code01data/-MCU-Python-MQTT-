%------------------------------------------------------------------------------------
%  第3.2章  MATLAB 绘制图像 ---三维数据曲线图 
%------------------------------------------------------------------------------------


% plot3() 三维点或线图
%{
    plot3(X,Y,Z) 绘制三维空间中的坐标。
        要绘制由线段连接的一组坐标，请将 X、Y、Z 指定为相同长度的向量。
        要在同一组坐标轴上绘制多组坐标，请将 X、Y 或 Z 中的至少一个指定为矩阵，其他指定为向量。
    plot3(X,Y,Z,LineSpec) 使用指定的线型、标记和颜色创建绘图。
    plot3(X1,Y1,Z1,...,Xn,Yn,Zn) 在同一组坐标轴上绘制多组坐标。使用此语法作为将多组坐标指定为矩阵的替代方法。
    plot3(X1,Y1,Z1,LineSpec1,...,Xn,Yn,Zn,LineSpecn) 可为每个 XYZ 三元组指定特定的线型、标记和颜色。
    您可以对某些三元组指定 LineSpec，而对其他三元组省略它。例如，plot3(X1,Y1,Z1,'o',X2,Y2,Z2) 对第一个三元组指定标记，但没有对第二个三元组指定标记。
    plot3(___,Name,Value) 使用一个或多个名称-值对组参数指定 Line 属性。在所有其他输入参数后指定属性。有关属性列表，请参阅 Line 属性。
%}

%  绘制1个线条
plot3_t = [0:pi/100:20*pi];
plot3_x1 = sin(plot3_t);
plot3_y1 = cos(plot3_t);
plot3_z1 = plot3_t.*sin(plot3_t) +plot3_t.*cos(plot3_t);
figure
plot3(plot3_x1,plot3_y1,plot3_z1)
grid 
title('三维曲线demo');
xlabel('X')
ylabel('Y')
zlabel('Z')

%绘制多个线条
t1 = 0:pi/500:pi;
xt1 = sin(t1).*cos(10*t1);
yt1 = sin(t1).*sin(10*t1);
zt1 = cos(t1);

xt2 = sin(t1).*cos(12*t1);
yt2 = sin(t1).*sin(12*t1);
zt2 = cos(t1);
figure
plot3(xt1,yt1,zt1,xt2,yt2,zt2) %plot3(x1,y1,z1,x2,y2,z2,.....,xn,yn,zn) 多条
title('绘制多个线条demo');
%使用矩阵绘制多个线条

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
title('矩阵 绘制多个线条demo');


% 三维网格图 meshgrid()
%{
    MATLAB提供了mesh函数和surf函数来绘制三维曲面图。mesh函数用于绘制三维网格图。
    在不需要绘制特别精细的三维曲面图时，可以通过三维网格图来表示三维曲面。surf用于绘制三维曲面图，各线条之间的补面用颜色填充。
    mesh函数和surf函数的调用格式如下：
    mesh（x,y,z,c）
    mesh(X,Y,Z) 创建一个网格图，该网格图为三维曲面，有实色边颜色，无面颜色。该函数将矩阵 Z 中的值绘制为由 X 和 Y 定义的 x-y 平面中的网格上方的高度。边颜色因 Z 指定的高度而异。
    surf（x,y,z,c）
%}
% [X,Y] = meshgrid(x,y) 基于向量 x 和 y 中包含的坐标返回二维网格坐标。
% X 是一个矩阵，每一行的行向量是 x;Y 也是一个矩阵，每一列的列向量是 x;坐标 X 和 Y 表示的网格有 length(y) 个行和 length(x) 个列。
% [X,Y] = meshgrid(x) 与 [X,Y] = meshgrid(x,x) 相同，并返回网格大小为 length(x)×length(x) 的方形网格坐标。
% [X,Y,Z] = meshgrid(x,y,z) 返回由向量 x、y 和 z 定义的三维网格坐标。X、Y 和 Z 表示的网格的大小为 length(y)×length(x)×length(z)。
% [X,Y,Z] = meshgrid(x) 与 [X,Y,Z] = meshgrid(x,x,x) 相同，并返回网格大小为 length(x)×length(x)×length(x) 的三维网格坐标。

% 二维网格
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

》X.^2+Y.^2

ans =

     2     5    10
     5     8    13
    10    13    18
    17    20    25
    26    29    34

》
%}

x2 = -2:0.25:2;
y2 = x2;
[X1,Y1] = meshgrid(x2);
F1 = X1.*exp(-X1.^2-Y1.^2);
% surf(x,y,x.*exp(-x.^2-(y').^2)) %可以直接使用，不需要生成网格
figure
surf(X1,Y1,F1) %surf(X,Y,Z) 创建一个三维曲面图，它是一个具有实色边和实色面的三维曲面。
% 该函数将矩阵 Z 中的值绘制为由 X 和 Y 定义的 x-y 平面中的网格上方的高度。曲面的颜色根据 Z 指定的高度而变化。
title('三维曲面图demo');


% 三维网格
x = 0:2:6;
y = 0:1:6;
z = 0:3:6;
[X,Y,Z] = meshgrid(x,y,z);
F = X.^2 + Y.^2 + Z.^2;
gridsize = size(F) % 确定网格的大小 gridsize = 7     4     3


[X2,Y2] = meshgrid(-8:.5:8);
R = sqrt(X2.^2 + Y2.^2) + eps;
Z2 = sin(R)./R;
figure
mesh(X2,Y2,Z2)
title('三维网格图demo');


%为网格图指定颜色图颜色  mesh(X,Y,Z,C)
% 通过包含第四个矩阵输入 C 来指定网格图的颜色。网格图使用 Z 确定高度，使用 C 确定颜色。使用颜色图指定颜色，该颜色图使用单个数字表示色谱上的颜色。
% 使用颜色图时，C 与 Z 大小相同。向图中添加颜色栏以显示 C 中的数据值如何对应于颜色图中的颜色。
[X3,Y3] = meshgrid(-8:.5:8);
R3 = sqrt(X3.^2 + Y3.^2) + eps;
Z3 = sin(R3)./R3;
C3 = X3.*Y3;
figure
mesh(X3,Y3,Z3,C3)
colorbar 
title('三维网格图 指定颜色demo');


%三维空间等高线图  contour3()
%{
    contour3(Z) 创建一个包含矩阵 Z 的等值线的三维等高线图，其中 Z 包含 x-y 平面上的高度值。MATLAB? 会自动选择要显示的等高线。
            Z 的列和行索引分别是平面中的 x 和 y 坐标。
    contour3(X,Y,Z) 指定 Z 中各值的 x 和 y 坐标。
    contour3(___,levels) 将要显示的等高线指定为上述任一语法中的最后一个参数。
            将 levels 指定为标量值 n，以在 n 个自动选择的层级（高度）上显示等高线。
            要在某些特定高度绘制等高线，请将 levels 指定为单调递增值的向量。要在一个高度 (k) 绘制等高线，请将 levels 指定为二元素行向量 [k k]。
    contour3(___,LineSpec) 指定等高线的线型和颜色。
    contour3(___,Name,Value) 使用一个或多个名称-值对组参数指定等高线图的其他选项。请在所有其他输入参数之后指定这些选项
%}
[X4,Y4,Z4] = sphere(50); %球体
figure
contour3(X4,Y4,Z4);
title('球体等高线demo');


[X5,Y5] = meshgrid(-5:0.25:5);
Z5 = X5.^2 + Y5.^2;
figure 
contour3(X5,Y5,Z5,50) %指定 50 等高线层级  contour3(X5,Y5,Z5,N)
title('指定50等高线层级');