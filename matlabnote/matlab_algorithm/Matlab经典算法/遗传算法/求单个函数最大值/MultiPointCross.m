%���ö�㽻�棬��������ɱ���������

function [Children1,Children2]=MultiPointCross(Parent1,Parent2)

global n Children1 Children2 VarNum
Children1=Parent1;
Children2=Parent2;
Points=sort(unidrnd(n,1,2*VarNum));
for i=1:VarNum
    Children1(Points(2*i-1):Points(2*i))=Parent2(Points(2*i-1):Points(2*i));
    Children2(Points(2*i-1):Points(2*i))=Parent1(Points(2*i-1):Points(2*i));
end