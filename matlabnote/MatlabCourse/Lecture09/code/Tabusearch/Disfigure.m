function Disfigure(best_so_far,RESULT,CS,MINZ,NT,MINL)
figure(1);
plot(1:size(RESULT,2),RESULT,'.-');
hold on
plot(1:size(best_so_far,2),best_so_far,'r-')
xlabel('��������')
ylabel('����ֵ')
str=['����' num2str(NT) '�Σ����Ž�ΪL=' num2str(MINL)];
title(str)
legend('RESULT','best so far',0)
grid on
hold off
figure(2);
plot(CS(:,1),CS(:,2),'bo')
hold on
for i=1:size(MINZ,2)
    plot(CS(MINZ(1,i),1),CS(MINZ(1,i),2),'r*')
    hold on
end
strr=['����վַΪ��' num2str(MINZ(1,1)) '��' ...
    num2str(MINZ(1,2)) '��' num2str(MINZ(1,3)) '��'...
    num2str(MINZ(1,4)) '��' num2str(MINZ(1,5)) '��'];
title(strr)
legend('��ѡվַ','����վַ',0)
plot(0,max(CS(:,2))+2,'.')
hold on
plot(max(CS(:,1))+2,max(CS(:,2))+2,'.')
hold on
plot(0,0,'.')
grid on
hold off
end