
% ��ͼ
% ʱ��ͼ
clc ;
clear;
close all;
global a b;
a=5;b=50;

[t, x] = ode45(@myFun, 0:0.001:500, [10,10,10,10]);
tm = floor(length(t) * 0.2):length(t);

% ��ͼ
EQU_VAR = ['x' 'y' 'z' 'w']; % ���̵�����
EQU_ORDER = 4; % ���÷��̽���


% ����3άͼ��
figure(1);
index = 1; % ����ͼ�α��
coordSet = [1, 2, 3]; % ͼ�ε���������
% subplot(2, 3, index);
plot3(x(tm,coordSet(1)), x(tm,coordSet(2)), x(tm,coordSet(3)),'m');
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
zlabel(EQU_VAR(coordSet(3)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2)),'-',EQU_VAR(coordSet(3))));

%---����ͼ������������
figure(5);
index = 5; % ����ͼ�α��
coordSet = [1, 2, 3]; % ͼ�ε���������
patch(x(tm,coordSet(1)), x(tm,coordSet(2)), x(tm,coordSet(3)),'edgecolor','flat','facecolor','none')
view(3);grid on;colorbar
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
zlabel(EQU_VAR(coordSet(3)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2)),'-',EQU_VAR(coordSet(3))));
% el=30;  %��������Ϊ30�ȡ�
% for az=0:1:360  %�÷�λ�Ǵ�0�䵽360����z��һ��
%     view(az,el);
%     drawnow;
% end
% pic_num = 1;
% for i=-1:- 1:-89   %%%    forѭ��
%     view(i,18);     %%%%    �ƶ��ӽ�
%     pause(0.09);     %%%%    ��ͣʱ��
%     F=getframe(gcf);
%     I=frame2im(F);
%     [I,map]=rgb2ind(I,256);
%     if pic_num == 1
%     imwrite(I,map,'test1.gif','gif','Loopcount',inf,'DelayTime',0.2);
%     else
%     imwrite(I,map,'test1.gif','gif','WriteMode','append','DelayTime',0.2);
%     end
%     pic_num = pic_num + 1;
% end


% ����2άͼ��
figure(2);
index = 2; % ����ͼ�α��
coordSet = [1, 2]; % ͼ�ε���������
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));

% ����2άͼ��
figure(3);
index = 3; % ����ͼ�α��
coordSet = [1, 3]; % ͼ�ε���������
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)),'b');
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));




% ����3άͼ��
figure(4);
index = 4; % ����ͼ�α��
coordSet = [2, 3, 4]; % ͼ�ε���������
% subplot(2, 3, index);
plot3(x(tm,coordSet(1)), x(tm,coordSet(2)), x(tm,coordSet(3)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
zlabel(EQU_VAR(coordSet(3)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2)),'-',EQU_VAR(coordSet(3))));

% ����2άͼ��
index = 5; % ����ͼ�α��
coordSet = [2, 3]; % ͼ�ε���������
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));

% ����2άͼ��
index = 6; % ����ͼ�α��
coordSet = [3, 4]; % ͼ�ε���������
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));


% ---------------- ʱ��ͼ -------------------------
% tm= floor(length(t) * 0):length(t);
% tm = 1:length(t);
% figure;
% 
% % ʱ��ͼ
% coordSet = 1; % ͼ�ε���������
% index = 1;  % ����ͼ�α��
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('ʱ��ͼ: t-',EQU_VAR(coordSet)));
% 
% % ʱ��ͼ
% 
% coordSet = coordSet + 1; % ͼ�ε���������
% index = index + 1;  % ����ͼ�α��
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('ʱ��ͼ: t-',EQU_VAR(coordSet)));
% 
% % ʱ��ͼ
% coordSet = coordSet + 1; % ͼ�ε���������
% index = index + 1;  % ����ͼ�α��
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('ʱ��ͼ: t-',EQU_VAR(coordSet)));
% 
% % ʱ��ͼ
% coordSet = coordSet + 1; % ͼ�ε���������
% index = index + 1;  % ����ͼ�α��
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('ʱ��ͼ: t-',EQU_VAR(coordSet)));


% subplot(2, 2, 4);
% plot(x(tm,1), x(tm,3));
% % xlim([-30, 30])  % ����x�������������
% xlabel('x');
% ylabel('z');
% title('x-z');




