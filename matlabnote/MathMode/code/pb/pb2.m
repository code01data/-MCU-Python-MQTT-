%统计分析 -- 判别分析 协方差矩阵不同

apf =  [1.14,1.78;1.18,1.96;1.20,1.86;1.26,2.;1.28,2;1.30,1.96];
af  = [1.24,1.72;1.36,1.74;1.38,1.64;1.38,1.82;1.38,1.90;1.40,1.70;1.48,1.82;1.54,1.82;1.56,2.08];
x = [1.24,1.8;1.28,1.84; 1.4,2.04]; 
W = mahal(x,apf)-mahal(x,af) %  计算判别函数


plot(apf(:,1),apf(:,2),'rh');
hold on
plot(af(:,1),af(:,2),'bp');
plot(x(:,1),x(:,2),'ko','MarkerFaceColor','y');
apfm  = mean(apf);


plot( apfm (1), apfm(2),'r*','LineWidth',2);
afm = mean(af);
plot( afm (1), afm(2),'b*','LineWidth',2)
legend('apf','af','待判断X','apf均值','af均值')
legend('boxoff')
title('判别分析 距离判别分析 测试案例 协方差矩阵不同的效果')