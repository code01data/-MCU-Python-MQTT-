%�������
function [NewPop]=CrossOver(OldPop,pCross,opts)
%OldPopΪ������Ⱥ��pcrossΪ�������
global m NewPop
r=rand(1,m);
y1=find(r<pCross);
y2=find(r>=pCross);
len=length(y1);
if len>2&&mod(len,2)==1%����������н����Ⱦɫ�������Ϊ�������������Ϊż��
    y2(length(y2)+1)=y1(len);
    y1(len)=[];
end
if length(y1)>=2
   for i=0:2:length(y1)-2
       if opts==0
           [NewPop(y1(i+1),:),NewPop(y1(i+2),:)]=EqualCrossOver(OldPop(y1(i+1),:),OldPop(y1(i+2),:));
       else
           [NewPop(y1(i+1),:),NewPop(y1(i+2),:)]=MultiPointCross(OldPop(y1(i+1),:),OldPop(y1(i+2),:));
       end
   end    
end
NewPop(y2,:)=OldPop(y2,:);