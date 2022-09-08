# matlab概念

### 知识点1 标准差 方差
![标准差.png](https://img1.imgtp.com/2022/08/05/hnKgo6Zr.png)
```matlab
%标准差std std(A,falg,dim) 默认flag=0,dim=1
std_B = std(mean_X,0,1) 
std_C = std(mean_A,0,1)   
std_D = std(mean_A,0,2)  
%方差var = std^2
var_B = var(mean_X,0,1)  
var_C = var(mean_A,0,1)  
var_D = var(mean_A,0,2) 
```


### 知识点2 累加和  累加积
![累加.png](https://img1.imgtp.com/2022/08/05/fbJ6NFkc.png)
```matlab
%累加和
% cumsum(mean_X) 返回向量的累加和向量
% cumsum(mean_A) 返回一个矩阵，其中第i个元素是第i列的累加和向量 (返回每列的累加和向量)
% cumsum(mean_A,1))返回一个矩阵，其中第i列是第i列的累加和向量 (返回每列的累加和向量)
% cumsum(mean_A,2) 返回一个矩阵，其中第i行是第i行的累加和向量 (返回每行的累加和向量)
%累加积
% cumprod(mean_X) 返回向量的累加积向量
% cumprod(mean_A) 返回一个矩阵，其中第i个元素是第i列的累加积向量 (返回每列的累加积向量)
% cumprod(mean_A,1))返回一个矩阵，其中第i列是第i列的累加积向量 (返回每列的累加积向量)
% cumprod(mean_A,2) 返回一个矩阵，其中第i行是第i行的累加积向量 (返回每行的累加积向量)
cumsum_B = cumsum(mean_X) 
cumsum_C = cumsum(mean_A)   
cumsum_D = cumsum(mean_A,2)  
cumprod_B = cumprod(mean_X)  
cumprod_C = cumprod(mean_A)  
cumprod_D = cumprod(mean_A,2) 

```
### 知识点3 相关系数
![相关系数.png](https://img1.imgtp.com/2022/08/05/fuTpqXHt.png)


### matlab 绘图
matlab绘图技巧笔记(https://zhuanlan.zhihu.com/p/345799328) 
#### 
```matlab
%legend在坐标区上添加图例
%legend 为每个绘制的数据序列创建一个带有描述性标签的图例。对于标签，图例使用数据序列的 DisplayName 属性中的文本。如果 DisplayName 属性为空，则图例使用 'dataN' 形式的标签。当您在坐标区上添加或删除数据序列时，图例会自动更新。此命令在由 gca 命令返回的当前坐标区中创建一个图例。如果当前坐标区为空，则图例为空。如果不存在坐标区，则 legend 创建一个笛卡尔坐标区。

legend(label1,...,labelN) %设置图例标签。以字符向量或字符串列表形式指定标签，例如 legend('Jan','Feb','Mar')。


%demo
x = linspace(0,pi);
y1 = cos(x);
plot(x,y1)

hold on 
y2 = cos(2*x);
plot(x,y2)

legend('cos(x)','cos(2x)')
```
[matlab legend文档](https://ww2.mathworks.cn/help/matlab/ref/legend.html)
![Snipaste_2022-09-02_09-29-27.png](https://img1.imgtp.com/2022/09/02/9pofp3Cl.png)
```matlab
a=linspace(1,2,10)

plot(a,'--pr','linewidth',1.5,'MarkerEdgeColor','r','MarkerFaceColor','m','MarkerSize',10)

legend('a','Location','best')

title('a','FontName','Times New Roman','FontWeight','Bold','FontSize',16)

xlabel('T','FontName','Times New Roman','FontSize',14)

ylabel('a','FontName','Times New Roman','FontSize',14,'Rotation',0)

axis auto equal

set(gca,'FontName','Times New Roman','FontSize',14)

 ```

1. 曲线线型、颜色和标记点类型
```matlab
plot(X1,Y1,LineSpec, …) 通过字符串LineSpec指定曲线的线型、颜色及数据点的标记类型。
     线型            颜色        数据点标记类型
 标识符  意义     标识符意义     标识符   意义
    -    实线     r   红色        +     加号
    -. 点划线     g   绿色        o     圆圈
   --    虚线     b   蓝色        *     星号
    :    点线     c  蓝绿色        .      点
                  m  洋红色       x   交叉符号
                  y   黄色   square(或s) 方格
                  k   黑色  diamond(或d) 菱形
                  w   白色       ^  向上的三角形
                                 v  向下的三角形
                                 >  向左的三角形
                                 <  向右的三角形
                             pentagram(或p) 五边形
                              hexagram(或h) 六边形

```
```matlab
2. 设置曲线线宽、标记点大小，标记点边框颜色和标记点填充颜色等。

plot(…,’Property Name’, Property Value, …)

Property Name 意义    选项
LineWidth 线宽    数值，如0.5，1等，单位为points
MarkerEdgeColor 标记点边框线条颜色颜色字符，如’g’, ’b’等
MarkerFaceColor 标记点内部区域填充颜色颜色字符
MarkerSize 标记点大小   数值，单位为points
```
```matlab
3. 坐标轴设置
范围设置：
a. axis([xmin xmax ymin ymax])设置坐标轴在指定的区间
b. axis auto 将当前绘图区的坐标轴范围设置为MATLAB自动调整的区间
c. axis manual 冻结当前坐标轴范围，以后叠加绘图都在当前坐标轴范围内显示
d. axis tight 采用紧密模式设置当前坐标轴范围，即以用户数据范围为坐标轴范围比例：

a. axis equal 等比例坐标轴
b. axis square 以当前坐标轴范围为基础，将坐标轴区域调整为方格形
c. axis normal 自动调整纵横轴比例，使当前坐标轴范围内的图形显示达到最佳效果
范围选项和比例设置可以联合使用，默认的设置为axis auto normal
 
```
```matlab
4.坐标轴刻度设置
set(gca, ’XTick’, [0 1 2]) X坐标轴刻度数据点位置
set(gca,'XTickLabel',{'a','b','c'}) X坐标轴刻度处显示的字符
set(gca,'FontName','Times New Roman','FontSize',14)设置坐标轴刻度字体名称，大小
‘FontWeight’,’bold’ 加粗 ‘FontAngle’,’italic’ 斜体
对字体的设置也可以用在title, xlabel, ylabel等中
```
```matlab
5.图例

legend('a','Location','best') 图例位置放在最佳位置
legend函数的基本用法是
legend(string1,string2,string3, ...)
分别将字符串1、字符串2、字符串3……标注到图中，每个字符串对应的图标为画图时的图标。
例如:
plot(x,sin(x),'.b',x,cos(x),'+r')
legend('sin','cos')% 这样可以把"."标识为'sin'，把"+"标识为"cos"
```
```matlab
6.更多的设置可以在绘图窗口中打开绘图工具，Inspector… 中查找
在使用Matlab时，经常需要将得到的数值表达成二维或三维图像。
plot(vector1,vector2)可以用来画两个矢量的二维图，例如
x=1:0.1:2*pi;
plot(x,sin(x))可以画正弦函数在0-2pi的上的图像。
plot函数可以接一些参数，来改变所画图像的属性（颜色，图像元素等）。下面是一些属性的说明
           b     blue（蓝色）       .     point（点）       -     solid（实线）
           g     green（绿色）      o     circle（圆圈）    :     dotted（点线)
           r     red（红色）        x     x-mark（叉号）    -.    dashdot (点画线）
           c     cyan（墨绿色）     +     plus(加号）       --    dashed(虚线）
           m     magenta（紫红色） *     star（星号）      (none) no line
           y     yellow（黄色）     s     square（正方形）
           k     black（黑色）      d     diamond（菱形）
                                   v     triangle (down)
                               ^     triangle (up)
                               <     triangle (left)
                               >     triangle (right)
                               p     pentagram
                               h     hexagram
例如，plot(x,y,'.r')表示用点来画图，点的颜色是红色。
plot函数可以接一些参数，来改变所画图像的属性（颜色，图像元素等）。下面是一些属性的说明
           b     blue（蓝色）       .     point（点）       -     solid（实线）
           g     green（绿色）      o     circle（圆圈）    :     dotted（点线)
           r     red（红色）        x     x-mark（叉号）    -.    dashdot (点画线）
           c     cyan（墨绿色）     +     plus(加号）       --    dashed(虚线）
           m     magenta（紫红色） *     star（星号）      (none) no line
           y     yellow（黄色）     s     square（正方形）
           k     black（黑色）      d     diamond（菱形）

                               v     triangle (down)
                               ^     triangle (up)
                               <     triangle (left)
                               >     triangle (right)
                               p     pentagram
                               h     hexagram
Example

       x = -pi:pi/10:pi;
       y = tan(sin(x)) - sin(tan(x));
       plot(x,y,'--rs','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
           xlabel('x');
           ylabel('y');
这些是Matlab help文件。后面一段是对应的翻译和说明
        'North'              inside plot box near top
        'South'              inside bottom
        'East'               inside right
        'West'               inside left
        'NorthEast'          inside top right (default)
        'NorthWest           inside top left
        'SouthEast'          inside bottom right
        'SouthWest'          inside bottom left
        'NorthOutside'       outside plot box near top
        'SouthOutside'       outside bottom
        'EastOutside'        outside right
        'WestOutside'        outside left
        'NorthEastOutside'   outside top right
        'NorthWestOutside'   outside top left
        'SouthEastOutside'   outside bottom right
        'SouthWestOutside'   outside bottom left
        'Best'               least conflict with data in plot
        'BestOutside'        least unused space outside plot
        'North'              图例标识放在图顶端
        'South'              图例标识放在图底端
        'East'               图例标识放在图右方
        'West'               图例标识放在图左方
        'NorthEast'          图例标识放在图右上方（默认）
        'NorthWest'          图例标识放在图左上方
        'SouthEast'          图例标识放在图右下角
        'SouthWest'          图例标识放在图左下角
以上几个都是将图例标识放在框图内
        'NorthOutside'          图例标识放在图框外侧上方
        'SouthOutside'         图例标识放在图框外侧下方
        'EastOutside'           图例标识放在图框外侧右方
        'WestOutside'          图例标识放在图框外侧左方
        'NorthEastOutside'   图例标识放在图框外侧右上方
        'NorthWestOutside' 图例标识放在图框外侧左上方
        'SouthEastOutside'   图例标识放在图框外侧右下方
        'SouthWestOutside' 图例标识放在图框外侧左下方
以上几个将图例标识放在框图外
        'Best'                      图标标识放在图框内不与图冲突的最佳位置
        'BestOutside'           图标标识放在图框外使用最小空间的最佳位置
还是用上面的例子

legend('sin','cos','location','northwest')%可以将标识框放置在图的左上角。

    Examples:
        x = 0:.2:12;
        plot(x,bessel(1,x),x,bessel(2,x),x,bessel(3,x));
        legend('First','Second','Third');
        legend('First','Second','Third','Location','NorthEastOutside')
        b = bar(rand(10,5),'stacked'); colormap(summer); hold on
        x = plot(1:10,5*rand(10,1),'marker','square','markersize',12,...
                 'markeredgecolor','y','markerfacecolor',[.6 0 .6],...
                 'linestyle','-','color','r','linewidth',2);
         hold off
        legend([b,x],'Carrots','Peas','Peppers','Green Beans',...
                  'Cucumbers','Eggplant')

```


