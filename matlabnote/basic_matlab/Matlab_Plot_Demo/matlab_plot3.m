%------------------------------------------------------------------------------------
%  第3.1章  MATLAB 绘制图像 ---二维数据曲线图 其他类型
%------------------------------------------------------------------------------------

% 半对数坐标图形绘制  (半对数坐标系) 
%  semilogx(),semilogy() 调用与plot类似
x = [0:0.5:5];
y = exp(x);

%绘图命令
figure

subplot(3, 1, 1)
plot(x,y,'r-')
set(get(gca, 'Title'), 'String', '笛卡尔坐标系') %title('笛卡尔坐标系')
subplot(3, 1, 2)
semilogx(x,y,'g-')
title('x轴对数坐标系')
subplot(3, 1, 3)
semilogy(x,y,'b-')
title('y轴对数坐标系')


% 对数坐标图形绘制 
%  loglog() 调用与plot类似


log_x = [0:0.5:5];
log_y = exp(log_x);

%绘图命令
figure

subplot(2, 1, 1)
plot(log_x,log_y,'r:','LineWidth',3)
set(get(gca, 'Title'), 'String', '笛卡尔坐标系') %title('笛卡尔坐标系')
subplot(2, 1, 2)
loglog(log_x,log_y,'b:','LineWidth',3)
title('对数坐标系')


% fplot()符号函数图形绘制   绘制函数表达式函数
%  fplot('fun',limites) 在指定的坐标范围limites内绘制函数fun()的图形
%  fplot('fun',limites,LineSpec) 在指定的坐标范围limites内绘制函数fun()的图形 LineSpec是图形绘制时采用的线型 数据点的样式颜色属性
%  fplot(f) 在默认区间 [-5 5]（对于 x）绘制由函数 y = f(x) 定义的曲线。 
%  fplot('fun',limites，err) 在指定的坐标范围limites内绘制函数fun()的图形 err不超过的相当误差
%  fplot(f,xinterval) 将在指定区间绘图。将区间指定为 [xmin xmax] 形式的二元素向量。

%  fplot(funx,funy) 在默认区间 [-5 5]（对于 t）绘制由 x = funx(t) 和 y = funy(t) 定义的曲线。
%  fplot(funx,funy,tinterval) 将在指定区间绘图。将区间指定为 [tmin tmax] 形式的二元素向量。
%  fplot(___,Name,Value) 使用一个或多个名称-值对组参数指定线条属性。例如，'LineWidth',2 指定 2 磅的线宽。
fp_x = [0:0.1:10]; 
fp_y1 = exp(fp_x);
fp_y2 = exp(fp_x).^2;
fp_y3 = (fp_x).^2+2*fp_x+1;

figure
subplot(4, 1, 1)
plot(fp_x,fp_y1)
title('y=e^x函数图形绘制')
subplot(4, 1, 2)
plot(fp_x,fp_y2)
title('y=(e^x)^2函数图形绘制')
subplot(4, 1, 3)
plot(fp_x,fp_y3)
title('y=x^2+2*x+1函数图形绘制')
subplot(4, 1,4)
%fplot('exp(fp_x)',[0,10],'r-.') 
fplot(@(fp_x)exp(fp_x),[0,10],'r-.') %新版本使用方法
title('y=e^x fplot函数图形绘制')


% 饼图绘制  

%{
    pie(X) 使用 X 中的数据绘制饼图。饼图的每个扇区代表 X 中的一个元素。
        如果 sum(X) ≤ 1，X 中的值直接指定饼图扇区的面积。如果 sum(X) < 1，pie 仅绘制部分饼图。
        如果 sum(X) > 1，则 pie 通过 X/sum(X) 对值进行归一化，以确定饼图的每个扇区的面积。
        如果 X 为 categorical 数据类型，则扇区对应于类别。每个扇区的面积是类别中的元素数除以 X 中的元素数的结果。
    pie(X,explode) 将扇区从饼图偏移一定位置。explode 是一个由与 X 对应的零值和非零值组成的向量或矩阵。
        pie 函数仅将对应于 explode 中的非零元素的扇区偏移一定的位置。
        如果 X 为 categorical 数据类型，则 explode 可以是由对应于类别的零值和非零值组成的向量，或者是由要偏移的类别名称组成的元胞数组。
    pie(X,labels) 指定扇区的文本标签。X 必须是数值数据类型。标签数必须等于 X 中的元素数。   
        pie(X,explode,labels) 偏移扇区并指定文本标签.
        X可以是数值或分类数据类型。对于数值数据类型的 X，标签数必须等于 X 中的元素数。对于分类数据类型的 X，标签数必须等于分类数。
%}

pie_x = [1,1,2,2,3,4,5];
pie_X = [500,120,100,200,1000];
explode = [1 1 1 1 1 1 1];
figure
subplot(3, 1,1)
pie(pie_x)
subplot(3, 1,2)
pie(pie_x,explode)
subplot(3, 1,3)
labels = {'生活费','资料费','网络费','购买衣服','旅行费用'}
pie(pie_X,labels) 

% 比较两个饼图
y2010 = [50 0 100 95];
y2011 = [65 22 97 120];
labels = {'Investments','Cash','Operations','Sales'};
figure
t = tiledlayout(2,1);
ax1 = nexttile;
pie(ax1,y2010)
legend(labels)
title('2010')

ax2 = nexttile;
pie(ax2,y2011)
legend(labels)
title('2011')

% 条形图 bar()

%{
    bar(y) 创建一个条形图，y 中的每个元素对应一个条形。如果 y 是 m×n 矩阵，则 bar 创建每组包含 n 个条形的 m 个组。
    bar(x,y) 在 x 指定的位置绘制条形。x必须单调增
    bar(___,width) 设置条形的相对宽度以控制组中各个条形的间隔。width 默认0.8
    将 width 指定为标量值。可以将此选项与前面语法中的任何输入参数组合一起使用。
    bar(___,style) 指定条形组的样式。style 两种类型 stacked group 例如，使用 'stacked' 将每个组显示为一个多种颜色的条形。 
    bar(___,color) 设置所有条形的颜色。例如，使用 'r' 表示红色条形。
    bar(___,Name,Value) 使用一个或多个名称-值对组参数指定条形图的属性。
        仅使用默认 'grouped' 或 'stacked' 样式的条形图支持设置条形属性。在所有其他输入参数之后指定名称-值对组参数。有关属性列表，请参阅 Bar 属性。
%}

bar_x = 1900:10:2000;
bar_y = [75 91 105 123.5 131 150 179 203 226 249 281.5];
bar_y1 = [2 2 3; 2 5 6; 2 8 9; 2 11 12];
figure
subplot(2, 1, 1)
bar(bar_x,bar_y) % 基本显示 
subplot(2, 1, 2)
bar(bar_y1) %显示条形组 垂直方向

bar_y2 = [2 2 3; 2 5 6; 2 8 9; 2 11 11];
figure
barh(bar_y2)% 水平方向

bar_X = [1:1:5];
bar_Y = [500,120,100,200,1000];

figure
bar(bar_X,bar_Y)
set(get(gca, 'Title'), 'String', '');
set(gca, 'xTicklabel', {'生活费','资料费','网络费','购买衣服','旅行费用'})



% 直方图 histogram
%{
    histogram(X) 基于 X 创建直方图。histogram 函数使用自动 bin 划分算法，然后返回均匀宽度的 bin，
    这些 bin 可涵盖 X 中的元素范围并显示分布的基本形状。histogram 将 bin 显示为矩形，这样每个矩形的高度就表示 bin 中的元素数量。
    histogram(X,nbins) 使用标量 nbins 指定的 bin 数量。
    histogram(X,edges) 将 X 划分到由向量 edges 来指定 bin 边界的 bin 内。
    每个 bin 都包含左边界，但不包含右边界，除了同时包含两个边界的最后一个 bin 外。
    histogram('BinEdges',edges,'BinCounts',counts) 手动指定 bin 边界和关联的 bin 计数。
    histogram 绘制指定的 bin 计数，而不执行任何数据的 bin 划分。
    histogram(C)（其中 C 为分类数组）通过为 C 中的每个类别绘制一个条形来绘制直方图。
    histogram(C,Categories) 仅绘制 Categories 指定的类别的子集。
    histogram('Categories',Categories,'BinCounts',counts) 手动指定类别和关联的 bin 计数。
    histogram 绘制指定的 bin 计数，而不执行任何数据的 bin 划分。
    histogram(___,Name,Value) 使用前面的任何语法指定具有一个或多个 Name,Value 对组参数的其他选项。
%}

% 向量直方图
%生成 10,000 个随机数并创建直方图。histogram 函数自动选择合适的 bin 数量，以便涵盖 x 中的值范围并显示基本分布的形状
histx = randn(10000,1);
figure
subplot(2, 1, 1)
histh = histogram(histx)
title('随机数据的向量直方图')
subplot(2, 1, 2)
histh1 = histogram(histx,25) %histogram(x,nbins) 使用标量 nbins 指定的 bin 数量。
title('等距的向量直方图')

  
% 面积图 填充区二维绘图 area

%{
    区域图将 Y 中的元素显示为一个或多个曲线并填充每个曲线下方的区域。如果 Y 为矩阵，则曲线堆叠在一起，显示每行元素占每个 x 区间的曲线总高度的相对量。
    area(Y) 绘制向量 Y 或将矩阵 Y 中每一列作为单独曲线绘制并堆叠显示。x 轴自动缩放到 1:size(Y,1)。Y 中的值可以是数值或持续时间值。
    area(X,Y) 绘制 Y 对 X 的图，并填充 0 和 Y 之间的区域。X 的值可以是数值、日期时间、持续时间或分类值。
    如果 Y 是向量，则将 X 指定为由递增值组成的向量，其长度等于 Y。如果 X 的值不增加，则 area 将在绘制之前对值进行排序。
    如果 Y 是矩阵，则将 X 指定为由递增值组成的向量，其长度等于 Y 的行数。area 将 Y 的列绘制为填充区域。对于每个 X，最终结果是 Y 行的相应值的和。
        您还可以将 X 指定为大小等于 Y 的矩阵。为了避免 X 为矩阵时出现意外输出，请将 X 的列指定为重复列。
    area(...,basevalue) 指定区域填充的基值。默认 basevalue 为 0。将基值指定为数值。
    area(...,Name,Value) 使用一个或多个名称-值对组参数修改区域图。

    area(y),以y为向量时，则以y的下标为横坐标，y中的各数据点连接成线，在默认情况下x轴作为基准线，填充x轴与连接线之间的区域部分
    当y为矩阵时，则绘制出多条曲线，填充
    area(x,y) 制定绘制面积图的横坐标
%}

area_x1 = [1,2,3,4];
area_x2 = [1,2,3,4;2,2,3,4];
figure
subplot(2,1,1)
area(area_x1)
title('向量面积图')
subplot(2,1,2)
area(area_x2)
title('矩阵面积图')

% scatter 散点图
% scatter(x,y) 在向量 x 和 y 指定的位置创建一个包含圆形的散点图。该类型的图形也称为气泡图。
% scatter(x,y,sz) 指定圆大小。要绘制大小相等的圆圈，请将 sz 指定为标量。要绘制大小不等的圆，请将 sz 指定为长度等于 x 和 y 的长度的向量。
% scatter(x,y,sz,c) 指定圆颜色。要以相同的颜色绘制所有圆圈，请将 c 指定为颜色名称或 RGB 三元组。
%                   要使用不同的颜色，请将 c 指定为向量或由 RGB 三元组组成的三列矩阵。


scatter_x = linspace(0,3*pi,200);
scatter_y = cos(scatter_x) + rand(1,200);  
figure
subplot(2, 1, 1)
scatter(scatter_x,scatter_y,10)
title('散点图')
subplot(2, 1, 2)
scatter(scatter_x,scatter_y,10,'r')
title('添加属性的散点图')


%pareto 帕累托图 排列图

% 帕累托图将向量 Y 中的值显示为降序排列的条形图。Y 中的值必须是非负的且不能包含 NaN。仅显示前 95% 的累积分布。
% pareto(Y) 用 Y 中的元素索引标识每个条形，并绘制线条以显示 Y 的累积和。
% pareto(Y,names) 用矩阵或元胞数组 names 中的关联文本标识每个条形。
% pareto(Y,X) 用 X 中的关联值标识每个条形。

pareto_x = [100,120,110,100,124];
names = {'No.1','No.2','No.3','No.4','No.5'};
figure
subplot(2, 1, 1)
pareto(pareto_x)
title(' 排列图')
subplot(2, 1, 2)
pareto(pareto_x,names)
title(' 标签排列图')
