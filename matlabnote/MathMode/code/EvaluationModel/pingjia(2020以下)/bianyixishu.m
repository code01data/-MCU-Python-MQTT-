function [Score,quan2]=bianyixishu(data1)
%���ݱ�׼�� 
data2=data1;
for j=1:size(data1,2)
    data2(:,j)= data1(:,j)./sqrt(sum(data1(:,j).^2));
end
%�������ϵ��
A=mean(data2);%��ÿ��ƽ��ֵ
S=std(data2);  %��ÿ�з���
V=S./A; %����ϵ��
%����Ȩ��
w=V./sum(V);
quan2=w;
%����÷�
s=data2*w';
Score=100*s/max(s);
end