function [R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ACATSP(City,Ite,Ant_num,Alpha,Beta,Rho,Q)
%% ��Ҫ����˵��
% City n�����е����꣬n��2�ľ���
% Ite ����������
% Ant_num ���ϸ���
% Alpha ������Ϣ����Ҫ�̶ȵĲ���
% Beta ��������ʽ������Ҫ�̶ȵĲ���
% Eta �������ӣ�������Ϊ����ĵ���
% Tau ��Ϣ�ؾ���
% Rho ��Ϣ������ϵ��
% Q ��Ϣ������ǿ��ϵ��
% R_best �������·��
% L_best �������·�ߵĳ���

%% ��һ����������ʼ��
City_num = size(City,1);%n��ʾ����Ĺ�ģ�����и�����
Distance = zeros(City_num,City_num);%D��ʾ��ȫͼ�ĸ�Ȩ�ڽӾ���

for i = 1:City_num
    for j = 1:City_num
       if i ~= j
            Distance(i,j) = sqrt( (City(i,1)-City(j,1))^2 + (City(i,2)-City(j,2))^2 );% ����������������
       else
            Distance(i,j) = eps;      % i=jʱ�����㣬Ӧ��Ϊ0�����������������Ҫȡ��������eps��������Ծ��ȣ���ʾ
       end
    Distance(j,i) = Distance(i,j);   % �Գƾ���
    end
end

Eta = 1./Distance;          % EtaΪ�������ӣ�������Ϊ����ĵ���
Tau = ones(City_num,City_num);     % TauΪ��Ϣ�ؾ���
Ite_num = 1;               % ��������������¼��������
R_rec = zeros(Ant_num,City_num);   % �洢����¼·��������
R_best = zeros(Ite,City_num);       % �������·��
L_best = inf.*ones(Ite,1);   % �������·�ߵĳ���
L_ave = zeros(Ite,1);        % ����·�ߵ�ƽ������

while Ite_num<=Ite        % ֹͣ����֮һ���ﵽ������������ֹͣ

%% �ڶ�������Ant_numֻ���Ϸŵ�City_num��������
    Init_ant_position = [];   % ����ʼ״̬�µ�����������䵽�������е���ʱ����
    for i = 1:( ceil(Ant_num/City_num) )
        Init_ant_position = [Init_ant_position,randperm(City_num)]; 
        % ÿ�ε���������������䵽���г��С�����һ��1�ж��У�����ceiling����ȡ�������������ڵ������ϸ������ľ���
    end    
    R_rec(:,1) = (Init_ant_position(1,1:Ant_num))';   
    % ����ת�ú��� Ant_num��-1�е�һ��һ����ʼ����ÿһ�д���һֻ���ϣ�ÿ��ֵ����ǰ�������ڳ��д��롣

%% ��������Ant_numֻ���ϰ����ʺ���ѡ����һ�����У���ɸ��Ե�����
    % ����˵���£����Ǹ����صĴ�ѭ��������ǳ��У��ڲ������ϡ�
    % Ҳ����˵ÿ�ε���ÿֻ������ǰ��һ����������һֻ�����������г����ٿ�ʼ��һֻ��
    for j = 2:City_num     % ���ڳ��в�����
        for i = 1:Ant_num    % ��ÿһֻ����
            City_visited = R_rec(i,1:(j-1));   % ��¼�ѷ��ʵĳ��У������ظ�����
            City_unvisited = zeros(1,(City_num-j+1));  % �����ʵĳ��У���ʼΪ��
            P = City_unvisited;   % �����ʳ��е�ѡ����ʷֲ����Ҳ���������Ū�˸����д������ʵֻ����Ūһ��ͬ�;���
            count = 1; % �����ʳ��� City_unvisited ���±������

            % ͳ��δȥ���ĳ���
            for k = 1:City_num
                if isempty( find( City_visited == k, 1 ) ) 
                    % ���ȥ��k���У���find��Ϊ��,find(x,1)����˼���ҵ���һ���ͽ�������һ������������ܵ�д����
                    % ��仰��Ϊ�˱����ظ�ȥͬһ�����С�
                    City_unvisited(count) = k; % ���if�ж�Ϊ�棬˵����k ������û��ȥ����
                    count = count+1;      % �±��������1
                end
            end

            % ��������ѡ���еĸ��ʷֲ�
            for k = 1:length(City_unvisited)
                P(k) = ( Tau( City_visited(end), City_unvisited(k) )^Alpha )*...
                       ( Eta( City_visited(end), City_unvisited(k) )^Beta );
            end
            P=P/(sum(P));

            % ������ԭ��ѡȡ��һ������
            P_cum = cumsum(P);  % cumsum������һ���Ƚ��������ͺ����������ǵõ�P ���ۻ����ʾ���
            Select = find(P_cum>=rand); % ������ĸ��ʴ���ԭ���ľ�ѡ������·��
            To_visit = City_unvisited(Select(1)); % Select(1)����˼��ѡ�е�һ���ۻ����ʴ���rand������ĳ���
            R_rec(i,j) = To_visit;  % R_rec(i,j) ��ָ��iֻ���ϣ��ڽ�Ҫȥj����Ҫȥ���Ǹ����У�ѭ��������õ�ÿֻ���ϵ�·��
        end
    end

    % ������ǵ�һ��ѭ����������·������·����¼����ĵ�һ��
    if Ite_num >= 2
        R_rec(1,:) = R_best(Ite_num-1,:);
    end

%% ���Ĳ�����¼���ε������·��
    Len = zeros(Ant_num,1);     % length ������󣬳�ʼΪ0����¼ÿֻ���ϵ�ǰ·�����ܾ��롣

    for i=1:Ant_num
        R_temp = R_rec(i,:); % ȡ�õ�i ֻ���ϵ�·��
        % �����iֻ�����߹����ܾ���
        for j = 1:(City_num-1)
            Len(i) = Len(i) + Distance( R_temp(j),R_temp(j+1) );  % ԭ������ϵ�j�����е���j+1�����еľ���
        end
        Len(i)=Len(i)+Distance(R_temp(1),R_temp(City_num));      % һ���������߹��ľ���
    end

    [L_best(Ite_num), index] = min(Len);     % ��Ѿ���ȡ��С
    R_best(Ite_num,:) = R_rec(index(1), :); 
    % ���ֵ���������·�ߡ�Ϊʲô��index(1)�������Ͻ�д������Ϊmin���������ж����Сֵ��index��Ψһ��
    L_ave(Ite_num) = mean(Len);           % ���ֵ������ƽ������
    Ite_num=Ite_num+1;                      % ��������

%% ���岽��������Ϣ��
    Delta_Tau = zeros(City_num, City_num);        % ��ʼʱ��Ϣ��Ϊn*n��0����

    for i = 1:Ant_num
        for j = 1:(City_num-1)
            Delta_Tau(R_rec(i,j), R_rec(i,j+1)) = Delta_Tau(R_rec(i,j), R_rec(i,j+1))+Q/Len(i);   
            %�˴�ѭ����·����i��j���ϵ���Ϣ������
        end
        Delta_Tau(R_rec(i,City_num), R_rec(i,1)) = Delta_Tau(R_rec(i,City_num), R_rec(i,1))+Q/Len(i);
        %�˴�ѭ��������·���ϵ���Ϣ������
    end

    Tau = (1-Rho).*Tau + Delta_Tau; %������Ϣ�ػӷ������º����Ϣ��  Rho ��Ϣ������ϵ��

%% �����������ɱ�����
    R_rec=zeros(Ant_num,City_num);             %%ֱ������������

end

%% ���߲���������

Pos = find(L_best==min(L_best)); % �ҵ����·������0Ϊ�棩
Shortest_Route=R_best(Pos(1), :) % ���������������·��
Shortest_Length=L_best(Pos(1) ) % ��������������̾���

figure                % ���Ƶ�һ����ͼ��
DrawRoute(City,Shortest_Route)     % ��·��ͼ���Ӻ���

figure                % ���Ƶڶ�����ͼ��
plot(L_best)
hold on                         % ����ͼ��
plot(L_ave,'r')
title('ƽ���������̾���')     % ����

