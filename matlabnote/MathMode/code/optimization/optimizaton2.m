%��Լ�������ķ����Թ滮(��Ŀ��--�Ż��㷨-�����Թ滮.md)
%����ͼ��
f3x = linspace(-pi, pi);
y3x = abs(1./(f3x));
plot(f3x, y3x,'ro');
set(get(gca, 'Title'), 'String', 'y = 1/abs(x) ͼ��');
grid on

x3_0 =1;%��ֵ
x3_1 =-3;
x3_2 =1;
[x1,fval1,exitflag] = fminbnd(@fun3, x3_1, x3_2) %��x3_1~x3_2֮�����ֵ
%fminunc�����Ż��ɹ��������Ǵ���ģ�fminunc��Ŀ�꺯����������������������Ŀ�꺯����������
[x2,fval2,exitflag] = fminunc(@fun3, x3_0)
%fminsearch�����Ż�ʧ�ܣ���Ϊ�ú���ֻ���������Ŀ�꺯����
[x3,fval3,exitflag] = fminsearch(@fun3, x3_0)