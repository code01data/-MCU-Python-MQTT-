%���þ��Ƚ���
function [children1,children2]=EqualCrossOver(parent1,parent2)

global n children1 children2
hidecode=round(rand(1,n));%�����������
crossposition=find(hidecode==1);
holdposition=find(hidecode==0);
children1(crossposition)=parent1(crossposition);%����Ϊ1����1Ϊ��1�ṩ����
children1(holdposition)=parent2(holdposition);%����Ϊ0����2Ϊ��1�ṩ����
children2(crossposition)=parent2(crossposition);%����Ϊ1����2Ϊ��2�ṩ����
children2(holdposition)=parent1(holdposition);%����Ϊ0����1Ϊ��2�ṩ����