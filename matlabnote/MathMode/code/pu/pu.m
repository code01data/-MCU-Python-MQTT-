%{
研究聚类的MATLAB实现，实现步骤大致如下：
（1）输入数据矩阵，注意行与列的实际意义；
（2）计算各样品之间的距离（行？列？）
    欧氏距离：d=pdist(A) % 注意计算A中各行之间的距离；
    绝对距离：d= pdist(A,'cityblock');
    明氏距离：d=pdist(A,'minkowski',r); % r要填上具体的实数；
    方差加权距离：d= pdist(A,'seuclid');
    马氏距离：d= pdist(A,'mahal');
    注意：以上命令输出的结果是一个行向量
(3) 选择不同的类间距离进行聚类
(4) 作出谱系聚类图
(5) 根据分类数目，输出聚类结果
%}


%题目
%{
下表是我国16个地区农民1982年支出情况的抽样调查的汇总资料，每个地区都调查了反映每人平均生活消费支出情况的六个指标。
试利用调查资料对16个地区进行聚类分析。

聚类分析结果
T =

     3
     2
     1
     1
     1
     2
     2
     1
     4
     2
     3
     2
     2
     2
     1
     1
%}
a=load('ho2.txt');%导入数据

d1=pdist(a);% 此时计算出各行之间的欧氏距离，

z1=linkage(d1);

z2=linkage(d1,'complete');

z3=linkage(d1,'average');

z4=linkage(d1,'centroid');

z5=linkage(d1,'ward');

R=[cophenet(z1,d1),cophenet(z2,d1),cophenet(z3,d1),cophenet(z4,d1),cophenet(z5,d1)]

H= dendrogram(z3)

T=cluster(z3,4)  %cluster 创建聚类，并作出谱系图

set(get(gca, 'Title'), 'String', '聚类分析-谱系聚类图');


