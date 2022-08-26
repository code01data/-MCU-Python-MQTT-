%定义法求最大lyapunov指数，求得多维系统中的最大lyapunov指数
%一般适用于：已知系统方程的系统最大lyapunov指数求解
%作者：张海龙
%时间：2011年4月5日
function  lya_pu=dingyi_lya(data)
%data:输入混沌时间序列
%m：  系统维数（非重构后的维数）
%lya_pu：输出最大lyapunov指数
N=length(data(:,1));
d_data=zeros(N,1);
[m,n]=size(data);
e_data=zeros(m,n);
d_data(1)=norm(data(1,:));
e_data(1,:)=data(1,:)'./d_data(1);
for i=2:N
    jac_temp=jacobian_jie(data(i-1,:));
    d_data(i)=norm(jac_temp*e_data(i-1,:));
    e_data(i)=(jac_temp*e_data(i-1,:))./d_data(i);
end
lya_pu=log(abs(prod(d_data)))/m;
