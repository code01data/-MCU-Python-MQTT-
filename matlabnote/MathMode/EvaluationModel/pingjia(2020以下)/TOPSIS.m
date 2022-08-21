function [score]=TOPSIS(X,W)   
%X��������ݣ�W��ָ���Ȩ��
[n,~]=size(X);
%Z=zscore(X);
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1); %�����һ��
V_D = sum(((Z - repmat(max(Z),n,1)) .^ 2 ) .* repmat(W,n,1) ,2) .^ 0.5; 
V_X = sum(((Z - repmat(min(Z),n,1)) .^ 2 ) .* repmat(W,n,1) ,2) .^ 0.5; 
S = V_X ./ (V_D+V_X); %δ��һ���÷�
Score_S = S / sum(S); %��һ���÷�,��Ϊÿ����ҵ��Ͷ�ʷ������֣�ֵԽ��Ͷ�ʷ���ҲԽ��
% score=Score_S;
 score=100*Score_S/max(Score_S);
end