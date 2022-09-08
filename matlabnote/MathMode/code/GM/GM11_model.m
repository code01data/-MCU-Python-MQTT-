function gm11 = GM11_model(X,td)

%GM11_model���ڻ�ɫģ��c��1��1���Ľ�����Ԥ��
%�������xΪԭʼ���ݣ�tdΪδ��Ԥ������
%�������gm11Ϊһ���ṹ�壬������
%Coeff_aΪ��չϵ����Coeff_uΪ����������
%Predict_ValueΪԤ��ֵ��������ǰֵ��δ��td��Ԥ��ֵ
%AbsoluteBrrorΪ������RelativeErrorMeanΪ�������ֵ
%CΪ����ȣ�P���ΪС���ʣ�RΪ������

%% ��������Ŀ�����Ĭ��ֵ

 if nargin < 2
    warning('�������Ϊ2����td��Ĭ��ʹ��Ĭ��ֵ5')
    td = 5;
 elseif td < 0
    warning('δ��Ԥ������td����Ϊ��ֵ��td��Ĭ��ʹ��Ĭ��ֵ0')
    td = 0;
 end
  
 %%����Ԥ�����ۼӣ�ƽ��
 n  = length(X);    %%��ȡԭʼ���ݸ���
 Ago = cumsum(X);    %% ԭʼ����һ���ۼ� ��ȡ��1-AGO����xi(1)
 % Z(i) Ϊxi(1)�Ľ��ھ�ֵ��������
 % Z = (Ago(1:n-1)+Ago(2:end))/2;
 Z = (Ago(1:end-1) + Ago(2:end) ) / 2;  % ������ھ�ֵ�������У�����Ϊn-1��

 %%����B��Ynz����
 Yn = X(2:end)'; %Yn�ǳ��������� X(2),x(3)
 B= [-Z;ones(1,n-1)]'; %% �ۼ�������������ֵ

 %% ��С���˷���ⷢչϵ��a�ͻ�ɫ������u

 LS_solution = (B'*B)\(B'*Yn); %% ���ù�ʽ���a,u
 a = LS_solution(1);   %%��չϵ��a
 u = LS_solution(2);  %%��ɫ������u


 %%�����Ҷ�GM(1,1)ģ�ͣ��׻�һԪһ��΢�ַ���
 F = [X(1),(X(1)-u/a)./exp(a*(1:n+td-1))+u/a];

 %% ��ԭ���У��õ�Ԥ������
 PreData = [F(1),F(2:end)-F(1:end-1)];


 %% ���ݿ��ӻ�
 t = 1:n;
 plot(t,X,'ko-','MarkerFaceColor','k')  %%ԭ����ͼ��
 hold on;
 grid on

 %%Ԥ�⵱ǰ����ͼ��
 plot(t,PreData(1:n),'b*-','LineWidth',1.5)  

 %% δ��td������ͼ��
 plot(n:n+td,PreData(n:n+td),'r*-','LineWidth',1.5)
 title('GM(1,1) model --- Original VS Current And Future Predict');
 legend('OriginalData','ForecastData','ForecastFutureData','Location','best')
 legend('boxoff')
 set(get(gca, 'XLabel'), 'String', 'Time');
 set(get(gca, 'YLabel'), 'String', 'Value');



 %% ģ��У��

 Err = abs(X-PreData(1:n));  %��ʵֵ��Ԥ��ֵ���
 q = mean(Err./X);%��ʵֵ��Ԥ��ֵ���
 XVar = std(X,1);%ԭ���ݵı�׼���ǰ������1/n
 ErrVar = std(Err(2:end):1);%�в2:end���ı�׼���ǰ������1/n
 C = ErrVar/XVar;  %���鷽���
 %С�����
 P = sum(abs(Err-mean(Err))<0.6745*XVar)/n;  
 R_k = (min(Err)+0.5*max(Err))./(Err+0.5*max(Err)); %rho=0.5
 R = sum(R_k)/length(R_k); %������

%%���������ϣ���������ṹ�����
 gm11.Coeff_a = a;
 gm11.Coeff_u = u;
 gm11.Predict_Value = PreData;
 gm11.AbsoluteError = Err;
 gm11.RelativeErrorMean = q;
 gm11.R = R;
 gm11.C = C;
 gm11.P = P;
 
    
end