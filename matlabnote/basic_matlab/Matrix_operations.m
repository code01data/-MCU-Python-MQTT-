%------------------------------------------------------------------------------------
%  第2.4章  MATLAB 矩阵的相关运算  (基本运算 点运算 关系运算(大小等于)) 逻辑运算(与或非) 
%------------------------------------------------------------------------------------
An13 = [1,2,3,4;1,8,27,64]  
% 1,2,3,4;
% 1,8,27,64  
b1 = An13(2,1) %指定A(m,n)  m行n列的元素(唯一)
b2 = An13(:,1) %指定A(:,n)  第n列全部元素
b3 = An13(2,:) %指定A(m,:)  第m行全部元素 
b4 = An13(:) % “单序号全部元素”生成的列向量  按照列向量 重新排序
%控制语句
%1.选择结构
%{ 
    (1)if

    if (条件)
       语句组1 
    end

    if (条件)
       语句组1 
    else
        语句组2 
    end

    if (条件)
       语句组1 
    elseif
        语句组2 
    elseif
        语句组3
        .....
    else
        语句组n
    end
    (1)switch(caseNum)
     switch (条件表达式)
       case caseNum1
             语句组1 
       case caseNum2
             语句组2 
       case caseNum3
             语句组3
             ....
       case caseNumm
             语句组m
             .... 
       otherwise %(排除其他所有的情况)
        语句n          

   (3). try 语句
try语句是一种试探性执行语句，为开发人员提供了一种捕获错误的机制，其语句格式如下：
    try
        语句组1
    catch
        语句组2
    end 
try语句先试探性执行语句组1，如果语句组1在执行过程中出现错误，则将错误信息赋给预定义变量lasterr，并转去执行语句组2。
如果不出错，则转去执行end后面的语句。
%}

%循环语句
%{
一般情况下，对于事先能确定循环次数的循环结构，使用for语句是比较方便的。
for语句的格式如下：
    for 循环变量=表达式1：表达式2：表达式3
        循环体语句
    end
eg:
    for i=1:1:1000
        b= 0.01*(i-1)
    end
    注意
    (1)for语句针对向量的每一个元素执行一次循环体，循环的次数就是向量中元素的个数，
    也可以针对任意向量。例如，下面的循环结构共循环4次，k的值分别为1、3、2、5。
    for k=[1,3,2,5]
        k
    end
    (2)虽然在内部改变了循环变量的值
    但当程序执行流程再次回到循环开始时，就会自动被设成向量的下一个元素。
    for k=[1,3,2,5]
    k
    k=20 %执行循环语句而已，最终还是会回去的最初的
    end

    (3)for语句中的3个表达式只在循环开始时计算一次，也就是说，向量元素一旦确定将不会再改变。
        如果在表达式中含有变量，即便在循环体中改变变量的值，向量的元素也不改变。
        例如，下列for语句中的向量元素为1、3、5、7、9，不会因循环体中改变n的值而改变向量的元素。
    n=2;
    for k=1:2:n+8   %3个表达式只在循环开始时计算一次,向量元素一旦确定将不会再改变,循环次数确定了
        n=5;
        k
    end

    (4)退出循环之后，循环变量的值就是向量中最后的元素值。
    (5)当向量为空时，循环体一次也不执行。
 
    2.
    while 语句就是通过判断循环条件是否满足来决定是否继续循环的一种循环控制语句，也称为条件循环语句。
    它的特点是先判断循环条件，条件满足时执行循环。
    while语句的一般格式如下:
        while (条件)
            循环体语句
        end
    3.break语句用于终止循环的执行(跳出整个循环)。当在循环体内执行到该语句时，程序将跳出循环，继续执行循环语句的下一语句。
    4.continue语句控制跳过循环体中的某些语句(跳出某个循环，直接进行下次循环)。
        当在循环体内执行到该语句时，程序将跳过循环体中所有剩下的语句，继续下一次循环
%}
%键盘输入input disp()
sum=0; 
n=0;
xin=input('Enter a number (end in 0):');
while xin~=0
    sum = sum +xin;
    n=n+1;
    xin=input('Enter a number (end in 0):');
end
if n>0
    sum
    mean = sum/n
end