function [Score]=zhuchengfen(data)
R=corr(data);
%%
%������������������ֵ
[V,D] = eig(R);  %V����������D����ֵ�Խ��߾���
%%
lam=diag(D);%ȡ���Խ���Ԫ��
%������ֵ�Ӵ�С����
[lam_sort,index]=sort(lam,'descend');
V_sort=V(:,index);
gong=lam_sort./sum(lam_sort); %������
cgong=cumsum(gong); %�ۼƹ�����
index1=find(cgong>=0.85);
index1=index1(1); %�ҵ��ۼƹ��״ﵽ85%��λ��
%%
M=data*V_sort;
M=M(:,1:index1);  %����ǵõ����µ��ۼƹ����ʳ���85%���ɷ�
%����Ϊ���µ����ɷ�����
M(:,find(sum(M)<0))=-M(:,find(sum(M)<0));
%M(find(sum()))=-M(:,2);
a=gong(1:index1);
%%
F=M.*a';
F=F';
s=sum(F);
Score=100*s/max(s);
end