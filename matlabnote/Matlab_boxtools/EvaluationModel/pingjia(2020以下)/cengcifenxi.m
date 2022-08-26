function [score1,quan] = cengcifenxi(A,data)
% A�б����
% A=[1,3,1,1/3;
%     1/3,1,1/2,1/5;
%     1,2,1,1/3;
%     3,5,3,1];
[n,~]=size(data);
%Z=zscore(X);
Z = data ./ repmat(sum(data.*data) .^ 0.5, n, 1); %�����һ��

[n,~]=size(A);
%������ֵ��������,�ҵ��������ֵ��Ӧ����������
[V,D]=eig(A);
tzz=max(max(D));     %�ҵ���������ֵ
c1=find(D(1,:)==tzz);%�ҵ���������ֵλ��
tzx=V(:,c1);%�������ֵ��Ӧ����������
%��Ȩ��
quan=zeros(n,1);
for i=1:n
quan(i,1)=tzx(i,1)/sum(tzx);
end
Q=quan;
%һ���Լ���
CI=(tzz-n)/(n-1);
RI=[0,0,0.58,0.9,1.12,1.24,1.32,1.41,1.45,1.49,1.52,1.54,1.56,1.58,1.59];
%�ж��Ƿ�ͨ��һ���Լ���
CR=CI/RI(1,n);
if CR>=0.1
   fprintf('û��ͨ��һ���Լ���\n');
else
  fprintf('ͨ��һ���Լ���\n');
end
 score=Z*Q;
 score1=100*score/max(score);
end