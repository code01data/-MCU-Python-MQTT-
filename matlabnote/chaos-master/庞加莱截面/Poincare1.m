clc
clear
% close all;
% global c;
% c = 2;

[t, Y] = ode45(@Siwei, 0:0.01:500, [1 1 1 1]);
A = 3;  % z 
B = 2;  % y
D = 1;  % x

m = 0;     % �����ֵ ������������ͼȷ������
N = length(Y);  % ��������ݵĳ��� 500 / 0.01 + 1
for k = 1 : N-1
    if (Y(k, A) > m && Y(k+1, A) < m) || (Y(k, A) < m && Y(k+1, A) > m)  % ��z���Ͻ�ȡһ��ƽ��
        a = (Y(k+1, A) - Y(k, A)) / (t(k+1) - t(k));                    % ѡȡ�Ľ���
        b = (Y(k, A) * t(k+1) - Y(k+1, A) * t(k)) / (t(k+1) - t(k));    % t = 0 z�ߵĽؾ�(����)
        c = (Y(k+1, B) - Y(k, B)) / (t(k+1) - t(k));                    % y�ߵ�б��
        d = (Y(k, B) * t(k+1) - Y(k+1, B) * t(k)) / (t(k+1) - t(k));    % t = 0 y�ߵĽؾ�(����)
        e = (Y(k+1, D) - Y(k, D)) / (t(k+1) - t(k));                    % x�ߵ�б��
        f = (Y(k, D) * t(k+1) - Y(k+1, D) * t(k)) / (t(k+1) - t(k));    % t = 0 x�ߵĽؾ�(����)
        g = (m - b) / a;    % z = 10ʱ����Ҫ������
        q = e * g + f;    	% z = 10ʱx��ֵ
        p = c * g + d;    	% z = 10ʱy��ֵ
        %disp ([k, q, p]);
        plot(q, p, '.');
        hold on;
    end
end

xlabel('x');
ylabel('y');