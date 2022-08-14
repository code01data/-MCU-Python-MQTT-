% �ֲ�ͼ
clc;
clear;
close all;
global a b c d ;   % ȫ�ֱ���
a = 6;
b = 4;
d = 2;

% ���ã������ı仯��Χ
value = 8:0.01:30;  % *�޸�1��������Χ
value_len = length(value);

num1 = zeros(1, 2);
numIndex = 1;
for i = 1:value_len
    fprintf('%f\n', value(i));
    coordX = value(i);   
    c = coordX;  	% *�޸�2������
    [T, Y] = ode45(@myFun, 0:0.01:100, [1 2 3 4]);
    data = Y(floor(length(T) * 0.5):end, 2);    % *�޸�3��Ҫ�۲������
    
    for j = 2:(length(data) - 1)
        if data(j) > data(j-1) && data(j) > data(j+1)
            plot(coordX, data(j), '.', 'markersize', 2);
            % �����ݵ���б��棬�����´λ�ͼ
            num1(numIndex, 1) = coordX;
            num1(numIndex, 2) = data(j);
            numIndex = numIndex + 1;
            hold on;
        end
    end

end

xlabel('\itC');
ylabel('\itYmax');
