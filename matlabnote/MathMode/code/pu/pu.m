%{
�о������MATLABʵ�֣�ʵ�ֲ���������£�
��1���������ݾ���ע�������е�ʵ�����壻
��2���������Ʒ֮��ľ��루�У��У���
    ŷ�Ͼ��룺d=pdist(A) % ע�����A�и���֮��ľ��룻
    ���Ծ��룺d= pdist(A,'cityblock');
    ���Ͼ��룺d=pdist(A,'minkowski',r); % rҪ���Ͼ����ʵ����
    �����Ȩ���룺d= pdist(A,'seuclid');
    ���Ͼ��룺d= pdist(A,'mahal');
    ע�⣺������������Ľ����һ��������
(3) ѡ��ͬ����������о���
(4) ������ϵ����ͼ
(5) ���ݷ�����Ŀ�����������
%}


%��Ŀ
%{
�±����ҹ�16������ũ��1982��֧������ĳ�������Ļ������ϣ�ÿ�������������˷�ӳÿ��ƽ����������֧�����������ָ�ꡣ
�����õ������϶�16���������о��������

����������
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
a=load('ho2.txt');%��������

d1=pdist(a);% ��ʱ���������֮���ŷ�Ͼ��룬

z1=linkage(d1);

z2=linkage(d1,'complete');

z3=linkage(d1,'average');

z4=linkage(d1,'centroid');

z5=linkage(d1,'ward');

R=[cophenet(z1,d1),cophenet(z2,d1),cophenet(z3,d1),cophenet(z4,d1),cophenet(z5,d1)]

H= dendrogram(z3)

T=cluster(z3,4)  %cluster �������࣬��������ϵͼ

set(get(gca, 'Title'), 'String', '�������-��ϵ����ͼ');

