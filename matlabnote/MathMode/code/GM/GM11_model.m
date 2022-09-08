function gm11 = GM11_model(X,td)

%GM11_model用于灰色模型c（1，1）的建立和预测
%输入参数x为原始数据，td为未来预测期数
%输出参数gm11为一个结构体，包括。
%Coeff_a为发展系数，Coeff_u为灰作用量，
%Predict_Value为预测值，包括当前值和未来td期预测值
%AbsoluteBrror为绝对误差，RelativeErrorMean为相对误差均值
%C为方差比，P误差为小概率，R为关联度

%% 输入参数的控制与默认值

 if nargin < 2
    warning('输入参数为2个，td将默认使用默认值5')
    td = 5;
 elseif td < 0
    warning('未来预测期数td不能为负值，td将默认使用默认值0')
    td = 0;
 end
  
 %%数据预处理：累加，平均
 n  = length(X);    %%获取原始数据个数
 Ago = cumsum(X);    %% 原始数据一次累加 获取新1-AGO序列xi(1)
 % Z(i) 为xi(1)的紧邻均值生成序列
 % Z = (Ago(1:n-1)+Ago(2:end))/2;
 Z = (Ago(1:end-1) + Ago(2:end) ) / 2;  % 计算紧邻均值生成数列（长度为n-1）

 %%构造B和Ynz矩阵
 Yn = X(2:end)'; %Yn是常数项向量 X(2),x(3)
 B= [-Z;ones(1,n-1)]'; %% 累加生成数据作均值

 %% 最小二乘法求解发展系数a和灰色作用量u

 LS_solution = (B'*B)\(B'*Yn); %% 利用公式求解a,u
 a = LS_solution(1);   %%发展系数a
 u = LS_solution(2);  %%灰色作用量u


 %%建立灰度GM(1,1)模型，白化一元一阶微分方程
 F = [X(1),(X(1)-u/a)./exp(a*(1:n+td-1))+u/a];

 %% 还原序列，得到预测数据
 PreData = [F(1),F(2:end)-F(1:end-1)];


 %% 数据可视化
 t = 1:n;
 plot(t,X,'ko-','MarkerFaceColor','k')  %%原数据图像
 hold on;
 grid on

 %%预测当前数据图像
 plot(t,PreData(1:n),'b*-','LineWidth',1.5)  

 %% 未来td期数据图像
 plot(n:n+td,PreData(n:n+td),'r*-','LineWidth',1.5)
 title('GM(1,1) model --- Original VS Current And Future Predict');
 legend('OriginalData','ForecastData','ForecastFutureData','Location','best')
 legend('boxoff')
 set(get(gca, 'XLabel'), 'String', 'Time');
 set(get(gca, 'YLabel'), 'String', 'Value');



 %% 模型校验

 Err = abs(X-PreData(1:n));  %真实值与预测值误差
 q = mean(Err./X);%真实值与预测值误差
 XVar = std(X,1);%原数据的标准方差，前置因子1/n
 ErrVar = std(Err(2:end):1);%残差（2:end）的标准方差，前置因子1/n
 C = ErrVar/XVar;  %后验方差比
 %小误差率
 P = sum(abs(Err-mean(Err))<0.6745*XVar)/n;  
 R_k = (min(Err)+0.5*max(Err))./(Err+0.5*max(Err)); %rho=0.5
 R = sum(R_k)/length(R_k); %关联度

%%计算变量组合，生成输出结构体变量
 gm11.Coeff_a = a;
 gm11.Coeff_u = u;
 gm11.Predict_Value = PreData;
 gm11.AbsoluteError = Err;
 gm11.RelativeErrorMean = q;
 gm11.R = R;
 gm11.C = C;
 gm11.P = P;
 
    
end