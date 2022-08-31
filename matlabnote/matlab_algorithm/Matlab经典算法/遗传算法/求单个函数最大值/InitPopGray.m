%��ʼ����Ⱥ
%���ö�����Gray����,��Ŀ����Ϊ�˿˷������Ʊ����Hamming����ȱ��
function [initpop]=InitPopGray(popsize,bits)
len=sum(bits);
initpop=zeros(popsize,len);%The whole zero encoding individual
for i=2:popsize-1
    pop=round(rand(1,len));
    pop=mod(([0 pop]+[pop 0]),2);
    %i=1ʱ,b(1)=a(1);i>1ʱ,b(i)=mod(a(i-1)+a(i),2)
    %����ԭ�����ƴ�:a(1)a(2)...a(n),Gray��:b(1)b(2)...b(n)
    initpop(i,:)=pop(1:end-1);
end
initpop(popsize,:)=ones(1,len);%The whole one encoding individual