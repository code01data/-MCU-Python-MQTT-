%ѡ�����
%���û������̶ķ��ķ���������ѡ��
%�������Ա����Ӧֵ�Ӵ�С����ѡ����ʣ�
%P(i)=(q/1-(1-q)^n)*(1-q)^i,  ���� P(0)>P(1)>...>P(n), sum(P(i))=1

function [selectpop]=NonlinearRankSelect(FUN,pop,bounds,bits)
global m n
selectpop=zeros(m,n);
fit=zeros(m,1);
for i=1:m
    fit(i)=feval(FUN(1,:),(b2f(pop(i,:),bounds,bits)));%�Ժ���ֵΪ��Ӧֵ����������
end
selectprob=fit/sum(fit);%��������������Ӧ��(0,1)
q=max(selectprob);%ѡ�����ŵĸ���
x=zeros(m,2);
x(:,1)=[m:-1:1]';
[y x(:,2)]=sort(selectprob);
r=q/(1-(1-q)^m);%��׼�ֲ���ֵ
newfit(x(:,2))=r*(1-q).^(x(:,1)-1);%����ѡ�����
newfit=cumsum(newfit);%�����ѡ�����֮��
rNums=sort(rand(m,1));
fitIn=1;newIn=1;
while newIn<=m
    if rNums(newIn)<newfit(fitIn)
        selectpop(newIn,:)=pop(fitIn,:);
        newIn=newIn+1;
    else
        fitIn=fitIn+1;
    end
end
