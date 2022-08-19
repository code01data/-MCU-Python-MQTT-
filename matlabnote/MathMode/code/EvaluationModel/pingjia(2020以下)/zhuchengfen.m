function [Score]=zhuchengfen(data)
R=corr(data);
%%
%计算特征向量和特征值
[V,D] = eig(R);  %V特征向量，D特征值对角线矩阵
%%
lam=diag(D);%取出对角线元素
%对特征值从大到小排列
[lam_sort,index]=sort(lam,'descend');
V_sort=V(:,index);
gong=lam_sort./sum(lam_sort); %贡献率
cgong=cumsum(gong); %累计贡献率
index1=find(cgong>=0.85);
index1=index1(1); %找到累计贡献达到85%的位置
%%
M=data*V_sort;
M=M(:,1:index1);  %这就是得到的新的累计贡献率超过85%主成分
%以下为用新的主成分评分
M(:,find(sum(M)<0))=-M(:,find(sum(M)<0));
%M(find(sum()))=-M(:,2);
a=gong(1:index1);
%%
F=M.*a';
F=F';
s=sum(F);
Score=100*s/max(s);
end