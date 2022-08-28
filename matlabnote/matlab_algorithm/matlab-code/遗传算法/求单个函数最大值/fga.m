
function [BestPop,Trace]=fga(FUN,LB,UB,eranum,popsize,pCross,pMutation,pInversion,options)
% [BestPop,Trace]=fmaxga(FUN,LB,UB,eranum,popsize,pcross,pmutation)
% Finds a  maximum of a function of several variables.
% fmaxga solves problems of the form: 
%      max F(X)  subject to:  LB <= X <= UB                           
%  BestPop       - ���ŵ�Ⱥ�弴Ϊ���ŵ�Ⱦɫ��Ⱥ
%  Trace         - ���Ⱦɫ������Ӧ��Ŀ�꺯��ֵ
%  FUN           - Ŀ�꺯��
%  LB            - �Ա�������
%  UB            - �Ա�������
%  eranum        - ��Ⱥ�Ĵ���,ȡ100--1000(Ĭ��200)
%  popsize       - ÿһ����Ⱥ�Ĺ�ģ���˿�ȡ50--200(Ĭ��100)
%  pcross        - �������,һ��ȡ0.5--0.85֮��Ϻ�(Ĭ��0.8)
%  pmutation     - ��ʼ�������,һ��ȡ0.05-0.2֮��Ϻ�(Ĭ��0.1)
%  pInversion    - ��λ����,һ��ȡ0.05��0.3֮��Ϻ�(Ĭ��0.2)
%  options       - 1*2����,options(1)=0�����Ʊ���(Ĭ��0),option(1)~=0ʮ���Ʊ�
%��,option(2)�趨��⾫��(Ĭ��1e-4)
%
%  ------------------------------------------------------------------------

T1=clock;
if nargin<3, error('FMAXGA requires at least three input arguments'); end
if nargin==3, eranum=200;popsize=100;pCross=0.8;pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==4, popsize=100;pCross=0.8;pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==5, pCross=0.8;pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==6, pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==7, pInversion=0.15;options=[0 1e-4];end
if find((LB-UB)>0)
   error('�����������,����������(LB<UB):');
end
s=sprintf('����������ҪԼ%.4f ����ʱ��,���Ե�......',(eranum*popsize/1000));
disp(s);

global m n NewPop children1 children2 VarNum

bounds=[LB;UB]';bits=[];VarNum=size(bounds,1);
precision=options(2);%����⾫��ȷ�������Ʊ��볤��
bits=ceil(log2((bounds(:,2)-bounds(:,1))' ./ precision));%���趨���Ȼ�������
[Pop]=InitPopGray(popsize,bits);%��ʼ����Ⱥ
[m,n]=size(Pop);
NewPop=zeros(m,n);
children1=zeros(1,n);
children2=zeros(1,n);
pm0=pMutation;
BestPop=zeros(eranum,n);%�����ʼ��ռ�BestPop,Trace
Trace=zeros(eranum,length(bits)+1);
i=1;
while i<=eranum
    for j=1:m
        value(j)=feval(FUN(1,:),(b2f(Pop(j,:),bounds,bits)));%������Ӧ��
    end
    [MaxValue,Index]=max(value);
    BestPop(i,:)=Pop(Index,:);
    Trace(i,1)=MaxValue;
    Trace(i,(2:length(bits)+1))=b2f(BestPop(i,:),bounds,bits);
    [selectpop]=NonlinearRankSelect(FUN,Pop,bounds,bits);%����������ѡ��
[CrossOverPop]=CrossOver(selectpop,pCross,round(unidrnd(eranum-i)/eranum));
%���ö�㽻��;��Ƚ��棬����������Ƚ���ĸ���
    %round(unidrnd(eranum-i)/eranum)
    [MutationPop]=Mutation(CrossOverPop,pMutation,VarNum);%����
    [InversionPop]=Inversion(MutationPop,pInversion);%��λ
    Pop=InversionPop;%����
pMutation=pm0+(i^4)*(pCross/3-pm0)/(eranum^4);
%������Ⱥ��ǰ�������������������1/2������
    p(i)=pMutation;
    i=i+1;
end
t=1:eranum;
plot(t,Trace(:,1)');
title('�����Ż����Ŵ��㷨');xlabel('����������(eranum)');ylabel('ÿһ��������Ӧ��(maxfitness)');
[MaxFval,I]=max(Trace(:,1));
X=Trace(I,(2:length(bits)+1));
hold on;  plot(I,MaxFval,'*');
text(I+5,MaxFval,['FMAX=' num2str(MaxFval)]);
str1=sprintf('������ %d �� ,�Ա���Ϊ %s ʱ,�ñ�����������ֵ %f\n��ӦȾɫ���ǣ�%s',I,num2str(X),MaxFval,num2str(BestPop(I,:)));
disp(str1);
%figure(2);plot(t,p);%���Ʊ���ֵ�������
T2=clock;
elapsed_time=T2-T1;
if elapsed_time(6)<0
    elapsed_time(6)=elapsed_time(6)+60; elapsed_time(5)=elapsed_time(5)-1;
end
if elapsed_time(5)<0
    elapsed_time(5)=elapsed_time(5)+60;elapsed_time(4)=elapsed_time(4)-1;
end  %�����ֳ���Ȼ������������Сʱ��
str2=sprintf('�������к�ʱ %d Сʱ %d ���� %.4f ��',elapsed_time(4),elapsed_time(5),elapsed_time(6));
disp(str2);

 




 



 



 








 








