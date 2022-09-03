x = load('1.txt')  %读取1.txt文件的数据
x_sort = sort(x)   %按照从小到大排序
dlmwrite('2.txt',x_sort)%  把变量写入到2.txt文件
%{
函数语法
dlmwrite(filename, M)
dlmwrite(filename, M, 'D')
dlmwrite(filename, M, 'D', R, C)
dlmwrite(filename, M, 'attrib1', value1, 'attrib2', value2, ...)
dlmwrite(filename, M, '-append')
dlmwrite(filename, M, '-append', attribute-value list) 

参数解析
dlmwrite(filename, M)
用默认的分隔符(逗号)将整个矩阵M写到文件名为filename的文本文件中
dlmwrite(filename, M, 'D')
用分隔符D(缺省为逗号，制表符可以用\t表示)将整个矩阵M写到filename文件中
dlmwrite(filename, M, 'D', R, C)
用分隔符D将部分矩阵M写到filename文件中：从矩阵的第R行，第C列开始写到文件中（R、C从零开始计算）。

dlmwrite(filename, M, 'attrib1', value1, 'attrib2', value2, ...) 
按一定的选项将矩阵M写到filename文件中，其中attrib1和value1为属性对，属性对参看下表。

属性					属性值

delimiter		分隔符,用来将矩阵中相邻两个元素分隔开
newline			newline的可选值为'pc'和'unix'，该属性与每行的结束符有关。newline为'pc'时，每行以\r\n(回车换行)结束，为'unix'时，每行以\n(换行)结束。
roffset			输出的矩阵数据前面所加的空行数
coffset			输出的矩阵数据前面所加的空列数
precision		输出的矩阵数据的精度，指定数据的有效数位或以C语言风格的格式输出（以%开始，如'%10.5f'）

dlmwrite(filename, M, '-append') 
在文件的末端输出矩阵M。如果没有指定-append选项，dlmwrite会覆盖已经存在的文件。

dlmwrite(filename, M, '-append', attribute-value list) 

允许使用属性对列表。
%}







例1:：

FileName='Data_dlmwrite.txt';

M=rand(4);

dlmwrite(FileName, M, 'delimiter' , '\t' , 'precision', 6)        
%将矩阵M导出到FileName文件中，分隔符为制表符，有效数位为6位。

type(FileName)

 

例2:：

FileName='Data_dlmwrite.txt';

M=rand(4);

dlmwrite(FileName, M, 'precision', '%.6f', 'newline', 'pc')        
%将矩阵M导出到FileName文件中，分隔符为默认的逗号，小数点后面保留六位，每行以\r\n结束。

type(FileName)        %可以试一下上面的newline属性改为unix再用记事本打开该文件

 

例3:：

FileName='Data_xlmwrite.txt';                %文件名

M = magic(3);

dlmwrite(FileName, [M*5 M/5], ' ')            %用dlmwrite函数先把数据(三行六列)写到文件,分隔符为空格

type(FileName)                                %先显示一次FileName的内容

dlmwrite(FileName, [M/3], '-append', 'roffset', 1, 'delimiter', ' ')       
 %再用dlmwrite往文件的未端添加数据(三行三列)(append代表添加,roffset代表添加一行空行,delimiter代表分隔符为空格)

type(FileName)                                %再显示一次更新后的FileName的内容

dlmread(FileName)                            %用dlmread函数载入文件,会发现后三行的后三列补零处理