%%�Ա���
function [Score,quan3]=CRITIC(data1)
the=std(data1);
%%ì����
r=corr(data1);%����ָ�������ϵ��
f=sum(1-r);
%%��Ϣ������
c=the.*f;
%����Ȩ��
w=c/sum(c);
quan3=w;
%����÷�
[n,m]=size(data1);
data= data1 ./ repmat(sum(data1.*data1) .^ 0.5, n, 1); %�����һ��
% data=mapminmax(data1',0.002,1);%��׼����0.002-1����
% data=data';
s=data*w';
Score=100*s/max(s);
end