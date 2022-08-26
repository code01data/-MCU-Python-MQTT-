%���巨�����lyapunovָ������ö�άϵͳ�е����lyapunovָ��
%һ�������ڣ���֪ϵͳ���̵�ϵͳ���lyapunovָ�����
%���ߣ��ź���
%ʱ�䣺2011��4��5��
function  lya_pu=dingyi_lya(data)
%data:�������ʱ������
%m��  ϵͳά�������ع����ά����
%lya_pu��������lyapunovָ��
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
