%��������ŵ��ָ��(Lyapunovָ����
clear;
close all;
format long;
% yinit = [1,1,1];
yinit = [0.1,0.1,0.1];%��ʼֵ
orthmatrix = [1 0 0;
              0 1 0;
              0 0 1];
% a = 0.15;
% b = 0.20;
% c = 10.0;
global a;
global b;
global c;
global d;
global n;
a=0.3;
c=0.3;
b=0.25;
n=6;%�о�����
  CountTime=50;%�������
%   for m=1:500
    for m=1:CountTime
      d=0.01*m;
      d
%===================һ�������ļ���  ��ʼ==========================
        y = zeros(12,1);
        % ��ʼ������
        y(1:3) = yinit;
        y(4:12) = orthmatrix; %����Ϊ˳��ֵ
        tstart = 0; % ʱ���ʼֵ
        tstep = 1e-3; % ʱ�䲽��
        %  wholetimes = 1e7; % �ܵ�ѭ������
%         wholetimes = 20000; % �ܵ�ѭ������
        wholetimes = 20000; % �ܵ�ѭ������
        steps = 10; % ÿ���ݻ��Ĳ��� 
        iteratetimes = wholetimes/steps; % �ݻ��Ĵ���
        mod = zeros(3,1);
        lp = zeros(3,1);
        % ��ʼ������Lyapunovָ��
        Lyapunov1 = zeros(iteratetimes,1);
        Lyapunov2 = zeros(iteratetimes,1);
        Lyapunov3 = zeros(iteratetimes,1);
        %==============�������ȶ���ֵ=============
        [T,Y]=ode45(@Multiscroll_LE,0:0.01:10,y);
        % y(1:3) = yinit;
        y(4:12) = orthmatrix; %����Ϊ˳��ֵ
        %==========================================
        %==============================����b����ĳ������ָ��  ��ʼ===================
        for i=1:iteratetimes
            tspan = tstart:tstep:(tstart + tstep*steps);   
        %     [T,Y] = ode45('Rossler_ly', tspan, y);
            [T,Y]=ode45(@Multiscroll_LE,tspan,y);
            % ȡ���ֵõ������һ��ʱ�̵�ֵ
            y = Y(size(Y,1),:);
            % ���¶�����ʼʱ��
            tstart = tstart + tstep*steps;
            y0 = [y(4) y(7) y(10);       %ת��Ϊԭ������ʽ
                  y(5) y(8) y(11);
                  y(6) y(9) y(12)];
            %������
            y0 = ThreeGS(y0); 
            % ȡ����������ģ
            mod(1) = sqrt(y0(:,1)'*y0(:,1)); %ȡģֵ
            mod(2) = sqrt(y0(:,2)'*y0(:,2));
            mod(3) = sqrt(y0(:,3)'*y0(:,3));
            y0(:,1) = y0(:,1)/mod(1);    %��λ��
            y0(:,2) = y0(:,2)/mod(2);
            y0(:,3) = y0(:,3)/mod(3);
            lp = lp+log(abs(mod));
            %����Lyapunovָ��
            Lyapunov1(i) = lp(1)/(tstart);
            Lyapunov2(i) = lp(2)/(tstart);
            Lyapunov3(i) = lp(3)/(tstart);
        %         y(4:12) = y0';
            y(4:12) = y0;
        end
%    % ��Lyapunovָ����ͼ
% i = 1:iteratetimes;
% plot(i,Lyapunov1,i,Lyapunov2,i,Lyapunov3);     
%==============================����b����ĳ������ָ��  ����===================
    Lyap1(m)=Lyapunov1(i-1);
    Lyap2(m)=Lyapunov2(i-1);
    Lyap3(m)=Lyapunov3(i-1);
    Lyap1(m)
    end;  
%===================һ�������ļ���  ��ʼ========================== 
   T=[1:CountTime]*0.01;
   plot(T,Lyap1,T,Lyap2,T,Lyap3);
   hold on;
   plot(T,0,'r');
   xlabel('d');
   ylabel('Lyapunov exponents');
%    title('a=c=0.3,b=0.25,n=6');
   
