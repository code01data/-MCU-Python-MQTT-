
% 相图
% 时域图
clc ;
clear;
close all;
global a b;
a=5;b=50;

[t, x] = ode45(@myFun, 0:0.001:500, [10,10,10,10]);
tm = floor(length(t) * 0.2):length(t);

% 绘图
EQU_VAR = ['x' 'y' 'z' 'w']; % 方程的因子
EQU_ORDER = 4; % 设置方程阶数


% 绘制3维图形
figure(1);
index = 1; % 设置图形编号
coordSet = [1, 2, 3]; % 图形的坐标数据
% subplot(2, 3, index);
plot3(x(tm,coordSet(1)), x(tm,coordSet(2)), x(tm,coordSet(3)),'m');
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
zlabel(EQU_VAR(coordSet(3)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2)),'-',EQU_VAR(coordSet(3))));

%---画动图——————
figure(5);
index = 5; % 设置图形编号
coordSet = [1, 2, 3]; % 图形的坐标数据
patch(x(tm,coordSet(1)), x(tm,coordSet(2)), x(tm,coordSet(3)),'edgecolor','flat','facecolor','none')
view(3);grid on;colorbar
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
zlabel(EQU_VAR(coordSet(3)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2)),'-',EQU_VAR(coordSet(3))));
% el=30;  %设置仰角为30度。
% for az=0:1:360  %让方位角从0变到360，绕z轴一周
%     view(az,el);
%     drawnow;
% end
% pic_num = 1;
% for i=-1:- 1:-89   %%%    for循环
%     view(i,18);     %%%%    移动视角
%     pause(0.09);     %%%%    暂停时间
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


% 绘制2维图形
figure(2);
index = 2; % 设置图形编号
coordSet = [1, 2]; % 图形的坐标数据
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));

% 绘制2维图形
figure(3);
index = 3; % 设置图形编号
coordSet = [1, 3]; % 图形的坐标数据
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)),'b');
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));




% 绘制3维图形
figure(4);
index = 4; % 设置图形编号
coordSet = [2, 3, 4]; % 图形的坐标数据
% subplot(2, 3, index);
plot3(x(tm,coordSet(1)), x(tm,coordSet(2)), x(tm,coordSet(3)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
zlabel(EQU_VAR(coordSet(3)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2)),'-',EQU_VAR(coordSet(3))));

% 绘制2维图形
index = 5; % 设置图形编号
coordSet = [2, 3]; % 图形的坐标数据
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));

% 绘制2维图形
index = 6; % 设置图形编号
coordSet = [3, 4]; % 图形的坐标数据
% subplot(2, 3, index);
plot(x(tm,coordSet(1)), x(tm,coordSet(2)));
xlabel(EQU_VAR(coordSet(1)));
ylabel(EQU_VAR(coordSet(2)));
title(strcat(EQU_VAR(coordSet(1)),'-',EQU_VAR(coordSet(2))));


% ---------------- 时域图 -------------------------
% tm= floor(length(t) * 0):length(t);
% tm = 1:length(t);
% figure;
% 
% % 时域图
% coordSet = 1; % 图形的坐标数据
% index = 1;  % 设置图形编号
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('时域图: t-',EQU_VAR(coordSet)));
% 
% % 时域图
% 
% coordSet = coordSet + 1; % 图形的坐标数据
% index = index + 1;  % 设置图形编号
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('时域图: t-',EQU_VAR(coordSet)));
% 
% % 时域图
% coordSet = coordSet + 1; % 图形的坐标数据
% index = index + 1;  % 设置图形编号
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('时域图: t-',EQU_VAR(coordSet)));
% 
% % 时域图
% coordSet = coordSet + 1; % 图形的坐标数据
% index = index + 1;  % 设置图形编号
% subplot(4, 1, index);
% plot(t(tm), x(tm,coordSet));
% xlabel('t');
% ylabel(EQU_VAR(coordSet));
% title(strcat('时域图: t-',EQU_VAR(coordSet)));


% subplot(2, 2, 4);
% plot(x(tm,1), x(tm,3));
% % xlim([-30, 30])  % 定义x坐标轴的上下限
% xlabel('x');
% ylabel('z');
% title('x-z');




