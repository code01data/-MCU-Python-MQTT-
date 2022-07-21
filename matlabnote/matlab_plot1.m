%------------------------------------------------------------------------------------
%  第3.1章  MATLAB 绘制图像 ---二维数据曲线图
%------------------------------------------------------------------------------------
%  1.单根二维曲线(二维曲线类型)
%------------------------------------------------------------------------------------
%线图 line()
%line(x,y)   %以向量x,y的元素为坐标点绘制直线 
%已知 x = [0:pi];y=2*sin(4*x);
% line_x = 0:1/pi:pi;
line_x = [0:pi];
line_y = 2*sin(4*line_x);
figure
line(line_x,line_y)
%line(x,y,z) %以向量x,y,z的元素为坐标点绘制三维直线
%已知 x = [0:pi];y = [0:pi]; z=2*sin(4.*x.*y);
line_x2 = 0:1/pi:pi;
line_y2 = 0:1/pi:pi;
line_z = 2*sin(4.*line_x2.*line_y2);
figure
line(line_x2,line_y2,line_z)
%极坐标 polarplot()
%极坐标 polarplot(theta,rho) 在极坐标中以角度theta和半径rho进行绘图
theta = 0:45;
rho = ones(1,length(theta));
figure
polarplot(theta, rho) 

%极坐标 polar(theta,rho,s) 在极坐标中以线性s绘制角度theta和半径rho的曲线
theta2 = 0:.01:2*pi;
rho2 = sin(2*theta2).*cos(2*theta2);
figure
polarplot(theta2, rho2,'--r') %以红色 -- 进行绘制


% 基本的绘图
x = 0:pi/100:2*pi;
y = sin(x);
figure
plot(x,y)
xlabel('x = 0:2\pi')  % xlabel坐标 函数中的字符 \pi 用于创建符号 π
ylabel('Sine of x')   % ylabel坐标
title('Plot of the Sine Function','FontSize',12)


% 在一幅图形中绘制多个数据集

x0 = 0:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x-.25);
y3 = cos(x-.5);
figure
plot(x0,y1,'+',x0,y2,'o',x0,y3,'*')  %plot(x,y1,x,y2,x,y3.....) 同一个x轴
% legend 函数提供了一种标识各条线的简单方法，如图4.4：
%legend('sin(x)','sin(x-.25)','cos(x-.5)')
legend('y1','y2','y3')
xlabel('x = 0:2\pi')  % xlabel坐标 函数中的字符 \pi 用于创建符号 π
ylabel('Sine of x')   % ylabel坐标
title('Plot of the Sine Function','FontSize',12)


%{
    使用 plot 命令绘制数据时，可以指定颜色、线型和标记 (例如加号或圆圈)：
    plot(x,y,'color_style_marker')
    color_style_marker 包含一至四个字符（包括在单引号中），这些字符根
    据颜色、线型和标记类型构造而成。例如，
    plot(x,y,'r:+')
    使用红色点线绘制数据，并在每个数据点处放置一个 + 标记。
%}

%------------------------------------------------------------------------------------
%  2.多根二维曲线(二维曲线类型)
%   y = linspace(x1,x2) 返回包含 x1 和 x2 之间的 100 个等间距点的行向量。
%   y = linspace(x1,x2,n) 生成 n 个点。这些点的间距为 (x2-x1)/(n-1)。
%   linspace 类似于冒号运算符“:”，但可以直接控制点数并始终包括端点。
%   “linspace”名称中的“lin”指示生成线性间距值而不是同级函数 logspace，后者会生成对数间距值。
%------------------------------------------------------------------------------------


%{
    plotyy(X1,Y1,X2,Y2) 绘制 Y1 对 X1 的图，在左侧显示 y 轴标签，并同时绘制 Y2 对 X2 的图，在右侧显示 y 轴标签。
    plotyy(X1,Y1,X2,Y2,function) 使用指定的绘图函数生成图形。
    function 可以是指定 plot、semilogx、semilogy、loglog、stem 的函数句柄或字符向量，或者是能接受以下语法的任意 MATLAB? 函数：
    h = function(x,y)
例如，
    plotyy(x1,y1,x2,y2,@loglog) % function handle
    plotyy(x1,y1,x2,y2,'loglog') % character vector
    函数句柄能够用于访问用户定义的局部函数，并能提供其他优势。有关使用函数句柄的详细信息，请参阅创建函数句柄。
    plotyy(X1,Y1,X2,Y2,'function1','function2') 使用 function1(X1,Y1) 绘制左轴的数据，使用 function2(X2,Y2) 绘制右轴的数据。
    plotyy(AX1,___) 使用第一组数据的 AX1 指定的坐标区（而不是使用当前坐标区）绘制数据。
    将 AX1 指定为单个坐标区对象或由以前调用 plotyy 所返回的两个坐标区对象的向量。
    如果您指定向量，则 plotyy 使用向量中的第一个坐标区对象。可以将此选项与前面语法中的任何输入参数组合一起使用。
    [AX,H1,H2] = plotyy(___) 返回 AX 中创建的两个坐标区的句柄，以及 H1 和 H2 中每个绘图的图形对象的句柄。AX(1) 是左边的坐标区，AX(2) 是右边的坐标区。
%}
% yyaxis 创建具有两个 y 轴的图
% yyaxis left 激活当前坐标区中与左侧 y 轴关联的一侧。后续图形命令的目标为左侧。
% 如果当前坐标区中没有两个 y 轴，此命令将添加第二个 y 轴。如果没有坐标区，此命令将首先创建坐标区。
% yyaxis right 激活当前坐标区中与右侧 y 轴关联的一侧。后续图形命令的目标为右侧。

yyaxis_x = linspace(0,10);
yyaxis_y = sin(3*yyaxis_x);
yyaxis left  %左侧 y 轴
plot(yyaxis_x,yyaxis_y,'r')

yyaxis_z = sin(3*yyaxis_x).*exp(0.5*yyaxis_x);
yyaxis right %右侧 y 轴
plot(yyaxis_x,yyaxis_z,'b')
ylim([-150 150]) %%y轴的范围大小

