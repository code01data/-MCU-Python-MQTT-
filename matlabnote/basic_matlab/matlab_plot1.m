%------------------------------------------------------------------------------------
%  ��3.1��  MATLAB ����ͼ�� ---��ά��������ͼ
%------------------------------------------------------------------------------------
%  1.������ά����(��ά��������)
%------------------------------------------------------------------------------------
%��ͼ line()
%line(x,y)   %������x,y��Ԫ��Ϊ��������ֱ�� 
%��֪ x = [0:pi];y=2*sin(4*x);
% line_x = 0:1/pi:pi;
line_x = [0:pi];
line_y = 2*sin(4*line_x);
figure
line(line_x,line_y)
%line(x,y,z) %������x,y,z��Ԫ��Ϊ����������άֱ��
%��֪ x = [0:pi];y = [0:pi]; z=2*sin(4.*x.*y);
line_x2 = 0:1/pi:pi;
line_y2 = 0:1/pi:pi;
line_z = 2*sin(4.*line_x2.*line_y2);
figure
line(line_x2,line_y2,line_z)
%������ polarplot()
%������ polarplot(theta,rho) �ڼ��������ԽǶ�theta�Ͱ뾶rho���л�ͼ
theta = 0:45;
rho = ones(1,length(theta));
figure
polarplot(theta, rho) 

%������ polar(theta,rho,s) �ڼ�������������s���ƽǶ�theta�Ͱ뾶rho������
theta2 = 0:.01:2*pi;
rho2 = sin(2*theta2).*cos(2*theta2);
figure
polarplot(theta2, rho2,'--r') %�Ժ�ɫ -- ���л���


% �����Ļ�ͼ
x = 0:pi/100:2*pi;
y = sin(x);
figure
plot(x,y)
xlabel('x = 0:2\pi')  % xlabel���� �����е��ַ� \pi ���ڴ������� ��
ylabel('Sine of x')   % ylabel����
title('Plot of the Sine Function','FontSize',12)


% ��һ��ͼ���л��ƶ�����ݼ�

x0 = 0:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x-.25);
y3 = cos(x-.5);
figure
plot(x0,y1,'+',x0,y2,'o',x0,y3,'*')  %plot(x,y1,x,y2,x,y3.....) ͬһ��x��
% legend �����ṩ��һ�ֱ�ʶ�����ߵļ򵥷�������ͼ4.4��
%legend('sin(x)','sin(x-.25)','cos(x-.5)')
legend('y1','y2','y3')
xlabel('x = 0:2\pi')  % xlabel���� �����е��ַ� \pi ���ڴ������� ��
ylabel('Sine of x')   % ylabel����
title('Plot of the Sine Function','FontSize',12)


%{
    ʹ�� plot �����������ʱ������ָ����ɫ�����ͺͱ�� (����ӺŻ�ԲȦ)��
    plot(x,y,'color_style_marker')
    color_style_marker ����һ���ĸ��ַ��������ڵ������У�����Щ�ַ���
    ����ɫ�����ͺͱ�����͹�����ɡ����磬
    plot(x,y,'r:+')
    ʹ�ú�ɫ���߻������ݣ�����ÿ�����ݵ㴦����һ�� + ��ǡ�
%}

%------------------------------------------------------------------------------------
%  2.�����ά����(��ά��������)
%   y = linspace(x1,x2) ���ذ��� x1 �� x2 ֮��� 100 ���ȼ������������
%   y = linspace(x1,x2,n) ���� n ���㡣��Щ��ļ��Ϊ (x2-x1)/(n-1)��
%   linspace ������ð���������:����������ֱ�ӿ��Ƶ�����ʼ�հ����˵㡣
%   ��linspace�������еġ�lin��ָʾ�������Լ��ֵ������ͬ������ logspace�����߻����ɶ������ֵ��
%------------------------------------------------------------------------------------


%{
    plotyy(X1,Y1,X2,Y2) ���� Y1 �� X1 ��ͼ���������ʾ y ���ǩ����ͬʱ���� Y2 �� X2 ��ͼ�����Ҳ���ʾ y ���ǩ��
    plotyy(X1,Y1,X2,Y2,function) ʹ��ָ���Ļ�ͼ��������ͼ�Ρ�
    function ������ָ�� plot��semilogx��semilogy��loglog��stem �ĺ���������ַ��������������ܽ��������﷨������ MATLAB? ������
    h = function(x,y)
���磬
    plotyy(x1,y1,x2,y2,@loglog) % function handle
    plotyy(x1,y1,x2,y2,'loglog') % character vector
    ��������ܹ����ڷ����û�����ľֲ������������ṩ�������ơ��й�ʹ�ú����������ϸ��Ϣ������Ĵ������������
    plotyy(X1,Y1,X2,Y2,'function1','function2') ʹ�� function1(X1,Y1) ������������ݣ�ʹ�� function2(X2,Y2) ������������ݡ�
    plotyy(AX1,___) ʹ�õ�һ�����ݵ� AX1 ָ������������������ʹ�õ�ǰ���������������ݡ�
    �� AX1 ָ��Ϊ�������������������ǰ���� plotyy �����ص����������������������
    �����ָ���������� plotyy ʹ�������еĵ�һ�����������󡣿��Խ���ѡ����ǰ���﷨�е��κ�����������һ��ʹ�á�
    [AX,H1,H2] = plotyy(___) ���� AX �д����������������ľ�����Լ� H1 �� H2 ��ÿ����ͼ��ͼ�ζ���ľ����AX(1) ����ߵ���������AX(2) ���ұߵ���������
%}
% yyaxis ������������ y ���ͼ
% yyaxis left ���ǰ������������� y �������һ�ࡣ����ͼ�������Ŀ��Ϊ��ࡣ
% �����ǰ��������û������ y �ᣬ�������ӵڶ��� y �ᡣ���û������������������ȴ�����������
% yyaxis right ���ǰ�����������Ҳ� y �������һ�ࡣ����ͼ�������Ŀ��Ϊ�Ҳࡣ

yyaxis_x = linspace(0,10);
yyaxis_y = sin(3*yyaxis_x);
yyaxis left  %��� y ��
plot(yyaxis_x,yyaxis_y,'r')

yyaxis_z = sin(3*yyaxis_x).*exp(0.5*yyaxis_x);
yyaxis right %�Ҳ� y ��
plot(yyaxis_x,yyaxis_z,'b')
ylim([-150 150]) %%y��ķ�Χ��С

